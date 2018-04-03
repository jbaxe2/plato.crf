library plato.angular.services.enrollments;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:http/http.dart' show Client, Response;

import 'package:angular/core.dart';

import 'enrollment.dart';
import 'enrollment_exception.dart';
import 'enrollment_factory.dart';

const String _ENROLLMENTS_URI = '/plato/retrieve/enrollments/instructor';

/// The [EnrollmentsService] class...
@Injectable()
class EnrollmentsService {
  List<Enrollment> enrollments;

  EnrollmentFactory _enrollmentFactory;

  final Client _http;

  static EnrollmentsService _instance;

  /// The [EnrollmentsService] factory constructor...
  factory EnrollmentsService (Client http) =>
    _instance ?? (_instance = new EnrollmentsService._ (http));

  /// The [EnrollmentsService] private constructor...
  EnrollmentsService._ (this._http) {
    enrollments = new List<Enrollment>();
    _enrollmentFactory = new EnrollmentFactory();
  }

  /// The [retrieveEnrollments] method...
  Future retrieveEnrollments() async {
    try {
      final Response enrollmentsResponse = await _http.get (_ENROLLMENTS_URI);

      List<Map<String, String>> rawEnrollments =
        (JSON.decode (enrollmentsResponse.body) as Map)['enrollments'];

      enrollments
        ..clear()
        ..addAll (_enrollmentFactory.createAll (rawEnrollments))
        ..sort();
    } catch (_) {
      throw new EnrollmentException (
        'Unable to properly retrieve and parse the enrollments.'
      );
    }
  }
}
