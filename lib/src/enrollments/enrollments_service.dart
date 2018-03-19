library plato.angular.services.enrollments;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:http/http.dart' show Client, Response;

import 'package:angular/core.dart';

import 'package:plato_angular/src/enrollments/enrollment.dart';
import 'package:plato_angular/src/enrollments/enrollments_exception.dart';

const String _ENROLLMENTS_URI = '/plato/retrieve/enrollments/instructor';

/// The [EnrollmentsService] class...
@Injectable()
class EnrollmentsService {
  List<Enrollment> enrollments;

  final Client _http;

  static EnrollmentsService _instance;

  /// The [EnrollmentsService] factory constructor...
  factory EnrollmentsService (Client http) =>
    _instance ?? (_instance = new EnrollmentsService._ (http));

  /// The [EnrollmentsService] private constructor...
  EnrollmentsService._ (this._http) {
    enrollments = new List<Enrollment>();
  }

  /// The [retrieveEnrollments] method...
  Future retrieveEnrollments() async {
    try {
      final Response enrollmentsResponse = await _http.get (_ENROLLMENTS_URI);

      List<Map<String, String>> rawEnrollments =
        (JSON.decode (enrollmentsResponse.body) as Map)['enrollments'];

      enrollments.clear();

      rawEnrollments.forEach ((Map<String, String> rawEnrollment) {
        if ('Instructor' != rawEnrollment['learn.membership.role']) {
          return;
        }

        var enrollment = new Enrollment (
          rawEnrollment['learn.user.username'], rawEnrollment['learn.course.id'],
          rawEnrollment['learn.course.name'], rawEnrollment['learn.membership.role'],
          rawEnrollment['learn.membership.available']
        );

        enrollments.add (enrollment);
      });

      enrollments.sort();
    } catch (_) {
      throw new EnrollmentsException (
        'Unable to properly retrieve and parse the enrollments.'
      );
    }
  }
}
