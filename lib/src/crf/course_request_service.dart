library plato.angular.services.crf.request_information;

import 'dart:async' show Future;

import 'package:http/http.dart' show Client, Response;

import '../user/user_information.dart';

import 'crf_exception.dart';
import 'request_information.dart';

const String _SUBMISSION_URI = '/plato/submit/crf';

/// The [CourseRequestService] class...
class CourseRequestService {
  RequestInformation requestInformation;

  final Client _http;

  static CourseRequestService _instance;

  /// The [CourseRequestService] factory constructor...
  factory CourseRequestService (Client http) =>
    _instance ?? (_instance = new CourseRequestService._ (http));

  /// The [CourseRequestService] private constructor...
  CourseRequestService._ (this._http);

  /// The [createRequestInformation] method...
  void createRequestInformation (UserInformation userInfo) {
    requestInformation = new RequestInformation (userInfo);
  }

  /// The [submitCrf] method...
  Future submitCrf() async {
    try {
      final Response crfResponse = await _http.post (_SUBMISSION_URI);
    } catch (_) {
      throw new CrfException (
        'An error has occurred while attempting to submit the course request.'
      );
    }
  }
}
