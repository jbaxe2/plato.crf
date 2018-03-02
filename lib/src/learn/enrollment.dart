library plato.angular.models.learn.enrollment;

/// The [Enrollment] class...
class Enrollment {
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
}
