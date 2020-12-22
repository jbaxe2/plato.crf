library plato.crf.factory.course;

import '../_application/factory/plato_factory.dart';

import 'course.dart';
import 'course_exception.dart';
import 'rejected_course.dart';

/// The [CourseFactory] class...
class CourseFactory implements PlatoFactory<Course> {
  /// The [CourseFactory] default constructor...
  CourseFactory();

  /// The [create] method...
  @override
  Course create (covariant Map<String, dynamic> rawCourse) {
    if (!(rawCourse.containsKey ('courseId') &&
          rawCourse.containsKey ('title'))) {
      throw CourseException();
    }

    return Course (rawCourse['courseId'], rawCourse['title']);
  }

  /// The [createAll] method...
  @override
  List<Course> createAll (covariant Iterable<Map<String, dynamic>> rawCourses) {
    var courses = <Course>[];

    try {
      rawCourses.forEach (
        (Object rawCourse) => courses.add (create (rawCourse as Map))
      );
    } catch (_) {
      rethrow;
    }

    return courses;
  }

  /// The [createRejectedCourse] method...
  RejectedCourse createRejectedCourse (Map<String, String> rawRejectedCourse) {
    return (create (rawRejectedCourse) as RejectedCourse);
  }

  /// The [createRejectedCourses] method...
  List<RejectedCourse> createRejectedCourses (
    Iterable<Map<String, String>> rawRejectedCourses
  ) {
    var rejectedCourses = <RejectedCourse>[];

    try {
      rawRejectedCourses.forEach ((Map<String, String> rawRejectedCourse) {
        rejectedCourses.add (createRejectedCourse (rawRejectedCourse));
      });
    } catch (_) {
      rethrow;
    }

    return rejectedCourses;
  }
}
