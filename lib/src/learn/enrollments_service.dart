library plato.angular.services.learn.enrollments;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:http/http.dart' show Client, Response;

import 'package:angular/core.dart';

import 'enrollment.dart';
import 'enrollments_exception.dart';

const String _ENROLLMENTS_URI = '/plato/retrieve/enrollments';

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
        var enrollment = new Enrollment (
          rawEnrollment['learn.user.username'], rawEnrollment['learn.course.id'],
          rawEnrollment['learn.course.name'], rawEnrollment['learn.membership.role'],
          rawEnrollment['learn.membership.available']
        );

        enrollments.add (enrollment);
      });
    } catch (_) {
      throw new EnrollmentsException (
        'Unable to properly retrieve and parse the enrollments.'
      );
    }
  }
}
