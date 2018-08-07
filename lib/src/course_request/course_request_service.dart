library plato.crf.services.course_request;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show json, utf8;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import '../_application/error/plato_exception.dart';
import '../_application/submission_response/submission_response.dart';

import '../courses/course_factory.dart';
import '../courses/rejected_course.dart';

import 'course_request_exception.dart';
import 'course_request.dart';

const String _SUBMISSION_URI = '/plato/submit/crf';

/// The [CourseRequestService] class...
@Injectable()
class CourseRequestService {
  CourseRequest _courseRequest;

  bool get submittable => _courseRequest.submittable;

  StreamController<CourseRequest> _requestController;

  StreamController<CourseRequest> get requestController => _requestController;

  StreamController<SubmissionResponse> _responseController;

  StreamController<SubmissionResponse> get responseController => _responseController;

  CourseFactory _courseFactory;

  final Client _http;

  static CourseRequestService _instance;

  /// The [CourseRequestService] factory constructor...
  factory CourseRequestService (Client http) =>
    _instance ?? (_instance = new CourseRequestService._ (http));

  /// The [CourseRequestService] private constructor...
  CourseRequestService._ (this._http) {
    _courseRequest = new CourseRequest();

    _requestController = new StreamController<CourseRequest>.broadcast();
    _responseController = new StreamController<SubmissionResponse>.broadcast();

    _courseFactory = new CourseFactory();
  }

  /// The [reviewCourseRequest] method...
  void reviewCourseRequest() {
    if (!submittable) {
      throw new CourseRequestException (
        'Unable to review and submit an incomplete course request.'
      );
    }

    _requestController.add (_courseRequest);
  }

  /// The [submitCourseRequest] method...
  Future submitCourseRequest() async {
    try {
      _courseRequest.verify();
    } catch (_) { rethrow; }

    try {
      final Response crfResponse = await _http.post (
        _SUBMISSION_URI, body: json.encode (_courseRequest.toJson())
      );

      _parseSubmissionResponse (
        json.decode (utf8.decode (crfResponse.bodyBytes))
      );
    } catch (e) {
      if (e is PlatoException) {
        rethrow;
      }

      throw new CourseRequestException (
        'An error has occurred while attempting to submit the course request.'
      );
    }
  }

  /// The [_parseSubmissionResponse] method...
  void _parseSubmissionResponse (Map<String, dynamic> submissionResponse) {
    if (submissionResponse.containsKey ('error')) {
      throw new CourseRequestException (submissionResponse['error']);
    }

    if (!(submissionResponse.containsKey ('result') &&
          submissionResponse.containsKey ('rejectedCourses'))) {
      throw new CourseRequestException (
        'The received response from submitting the request resulted in error.'
      );
    }

    var rejectedCourses = new List<RejectedCourse>();

    try {
      if ((submissionResponse['result'] as String).contains ('partial')) {
        var rawRejectedCourses =
          submissionResponse['rejectedCourses'] as List<Map<String, String>>;

        rejectedCourses.addAll (
          _courseFactory.createRejectedCourses (rawRejectedCourses)
        );
      }
    } catch (_) {
      throw new CourseRequestException (
        'Some courses were rejected, but the response from the server was '
        'improperly formatted.'
      );
    }

    _responseController.add (
      new SubmissionResponse (
        ('success' == submissionResponse['result'] as String),
        rejectedCourses
      )
    );
  }
}
