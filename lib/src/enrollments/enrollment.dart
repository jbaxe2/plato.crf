library plato.crf.models.learn.enrollment;

import 'enrollment_exception.dart';

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

  /// The [==] operator...
  @override
  bool operator ==(Object other) {
    if (identical (this, other)) {
      return true;
    }

    if (other is Enrollment) {
      if ((other.username == username) &&
          (other.courseId == courseId) &&
          (other.courseName == courseName) &&
          (other.role == role) &&
          (other.available == available) &&
          (other.isArchive == isArchive)) {
        return true;
      };
    }

    return false;
  }

  /// The [hashCode] getter...
  @override
  int get hashCode {
    int result = 3;

    result = 7 * result + ((null == username) ? 0 : username.hashCode);
    result = 7 * result + ((null == courseId) ? 0 : courseId.hashCode);
    result = 7 * result + ((null == courseName) ? 0 : courseName.hashCode);
    result = 7 * result + ((null == role) ? 0 : role.hashCode);
    result = 7 * result + ((null == available) ? 0 : available.hashCode);
    result = 7 * result + isArchive.hashCode;

    return result;
  }

  /// The [compareTo] method...
  int compareTo (dynamic other) {
    if (!(other is Enrollment)) {
      throw new EnrollmentException ('Cannot compare an enrollment to some other type.');
    }

    return courseId.compareTo (other.courseId);
  }

  /// The [toJson] method...
  Object toJson() {
    return {
      'username': username,
      'courseId': courseId,
      'courseName': courseName,
      'role': role,
      'available': available,
      'isArchive': isArchive.toString()
    };
  }
}
