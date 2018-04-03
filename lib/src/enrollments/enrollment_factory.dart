library plato.angular.factory.enrollment;

import '../_application/factory/plato_factory.dart';

import 'enrollment.dart';
import 'enrollments_exception.dart';

/// The [EnrollmentFactory] class...
class EnrollmentFactory implements PlatoFactory<Enrollment> {
  /// The [EnrollmentFactory] default constructor...
  EnrollmentFactory();

  /// The [create] method...
  @override
  Enrollment create (Map<String, dynamic> rawEnrollment) {
    ;
  }

  /// The [createAll] method...
  @override
  List<Enrollment> createAll (Iterable<Map<String, dynamic>> rawEnrollments) {
    ;
  }
}
