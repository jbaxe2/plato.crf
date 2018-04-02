library plato.angular.services.course_request;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show JSON;

import 'package:http/http.dart' show Client, Response;

import 'package:angular/core.dart';

import '../courses/rejected_course.dart';

import '../user/user_information.dart';

import 'course_request_exception.dart';
import 'course_request.dart';

const String _SUBMISSION_URI = '/plato/submit/crf';

/// The [CourseRequestService] class...
@Injectable()
class CourseRequestService {
  CourseRequest _courseRequest;

  final Client _http;

  bool get submittable => _courseRequest.submittable;

  StreamController<CourseRequest> requestController;

  StreamController<List<RejectedCourse>> rejectedController;

  static CourseRequestService _instance;

  /// The [CourseRequestService] factory constructor...
  factory CourseRequestService (Client http) =>
    _instance ?? (_instance = new CourseRequestService._ (http));

  /// The [CourseRequestService] private constructor...
  CourseRequestService._ (this._http) {
    _courseRequest = new CourseRequest();

    requestController = new StreamController<CourseRequest>.broadcast();
    rejectedController = new StreamController<List<RejectedCourse>>.broadcast();
  }

  /// The [setUserInformation] method...
  void setUserInformation (UserInformation userInformation) {
    try {
      _courseRequest.setUserInformation (userInformation);
    } catch (_) { rethrow; }
  }

  /// The [reviewCourseRequest] method...
  void reviewCourseRequest() {
    if (!submittable) {
      throw new CourseRequestException (
        'Unable to review and submit an incomplete course request.'
      );
    }

    requestController.add (_courseRequest);
  }

  /// The [submitCourseRequest] method...
  Future submitCourseRequest() async {
    try {
      _courseRequest.verify();
    } catch (_) { rethrow; }

    try {
      final Response crfResponse = await _http.post (
        _SUBMISSION_URI, body: JSON.encode (_courseRequest.toJson())
      );

      _parseSubmissionResponse (JSON.decode (crfResponse.body));
    } catch (_) {
      throw new CourseRequestException (
        'An error has occurred while attempting to submit the course request.'
      );
    }
  }

  /// The [_parseSubmissionResponse] method...
  void _parseSubmissionResponse (Map<String, dynamic> submissionResponse) {
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

        rawRejectedCourses.forEach ((Map<String, String> rawRejectedCourse) {
          rejectedCourses.add (
            new RejectedCourse (
              rawRejectedCourse['id'], rawRejectedCourse['title']
            )
          );
        });
      }
    } catch (_) {
      throw new CourseRequestException (
        'Some courses were rejected, but the response from the server was '
        'improperly formatted.'
      );
    }

    rejectedController.add (rejectedCourses);
  }
}
