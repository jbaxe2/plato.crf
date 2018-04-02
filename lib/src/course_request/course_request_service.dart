library plato.angular.services.course_request;

import 'dart:async' show Future, StreamController;

import 'package:http/http.dart' show Client, Response;

import 'package:angular/core.dart';

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

  static CourseRequestService _instance;

  /// The [CourseRequestService] factory constructor...
  factory CourseRequestService (Client http) =>
    _instance ?? (_instance = new CourseRequestService._ (http));

  /// The [CourseRequestService] private constructor...
  CourseRequestService._ (this._http) {
    _courseRequest = new CourseRequest();
    requestController = new StreamController<CourseRequest>.broadcast();
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
      _validateCourseRequest();
    } catch (_) { rethrow; }

    try {
      final Response crfResponse = await _http.post (
        _SUBMISSION_URI, body: _courseRequest.toJson()
      );

      crfResponse.body;
    } catch (_) {
      throw new CourseRequestException (
        'An error has occurred while attempting to submit the course request.'
      );
    }
  }

  /// The [_validateCourseRequest] method...
  void _validateCourseRequest() {
    try {
      _courseRequest.verify();
    } catch (_) {
      rethrow;
    }
  }
}
