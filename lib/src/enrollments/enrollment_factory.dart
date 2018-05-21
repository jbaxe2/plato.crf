library plato.crf.factory.enrollment;

import '../_application/factory/plato_factory.dart';

import 'enrollment.dart';
import 'enrollment_exception.dart';

/// The [EnrollmentFactory] class...
class EnrollmentFactory implements PlatoFactory<Enrollment> {
  /// The [EnrollmentFactory] default constructor...
  EnrollmentFactory();

  /// The [create] method...
  @override
  Enrollment create (Map<String, dynamic> rawEnrollment, [bool asArchive = false]) {
    if (!(rawEnrollment.containsKey ('learn.user.username') &&
          rawEnrollment.containsKey ('learn.course.id') &&
          rawEnrollment.containsKey ('learn.course.name') &&
          rawEnrollment.containsKey ('learn.membership.role') &&
          rawEnrollment.containsKey ('learn.membership.available'))) {
      throw new EnrollmentException (
        'The provided enrollment was not formatted correctly.'
      );
    }

    if ('Instructor' != rawEnrollment['learn.membership.role']) {
      throw new EnrollmentException (
        'The provided enrollment was not for an instructor membership.'
      );
    }

    return new Enrollment (
      rawEnrollment['learn.user.username'], rawEnrollment['learn.course.id'],
      rawEnrollment['learn.course.name'], rawEnrollment['learn.membership.role'],
      rawEnrollment['learn.membership.available'],
      isArchive: asArchive
    );
  }

  /// The [createAll] method...
  @override
  List<Enrollment> createAll (
    Iterable<Map<String, dynamic>> rawEnrollments, [bool asArchives = false]
  ) {
    var enrollments = new List<Enrollment>();

    try {
      rawEnrollments.forEach ((Map<String, dynamic> rawEnrollment) {
        enrollments.add (create (rawEnrollment, asArchives));
      });
    } catch (_) {
      rethrow;
    }

    return enrollments;
  }
}
