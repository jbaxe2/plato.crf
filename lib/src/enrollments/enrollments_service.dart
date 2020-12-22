library plato.crf.services.enrollments;

import 'dart:async' show Future;
import 'dart:convert' show json, utf8;

import 'package:http/http.dart' show Client, Response;

import 'enrollment.dart';
import 'enrollment_exception.dart';
import 'enrollment_factory.dart';

const String _ENROLLMENTS_URI = '/plato/retrieve/enrollments/instructor';

/// The [EnrollmentsService] class...
class EnrollmentsService {
  List<Enrollment> enrollments;

  EnrollmentFactory _enrollmentFactory;

  final Client _http;

  static EnrollmentsService _instance;

  /// The [EnrollmentsService] factory constructor...
  factory EnrollmentsService (Client http) =>
    _instance ?? (_instance = EnrollmentsService._ (http));

  /// The [EnrollmentsService] private constructor...
  EnrollmentsService._ (this._http) {
    enrollments = <Enrollment>[];
    _enrollmentFactory = EnrollmentFactory();
  }

  /// The [retrieveEnrollments] method...
  Future<void> retrieveEnrollments() async {
    try {
      final enrollmentsResponse = await _http.get (_ENROLLMENTS_URI);

      List<Map<String, String>> rawEnrollments =
        (json.decode (utf8.decode (enrollmentsResponse.bodyBytes)) as Map)['enrollments'];

      enrollments
        ..clear()
        ..addAll (_enrollmentFactory.createAll (rawEnrollments))
        ..sort();
    } catch (_) {
      throw EnrollmentException (
        'Unable to properly retrieve and parse the enrollments.'
      );
    }
  }
}
