library plato.angular.models.learn.enrollment;

import 'enrollments_exception.dart';

/// The [Enrollment] class...
class Enrollment implements Comparable {
  final String username;

  final String courseId;

  final String courseName;

  final String role;

  final String available;

  final bool isArchive;

  /// The [Enrollment] constructor...
  Enrollment (
    this.username, this.courseId, this.courseName, this.role, this.available,
    {this.isArchive: false}
  );

  /// The [compareTo] method...
  int compareTo (dynamic other) {
    if (!(other is Enrollment)) {
      throw new EnrollmentsException ('Cannot compare an enrollment to some other type.');
    }

    return courseId.compareTo (other.courseId);
  }
}
