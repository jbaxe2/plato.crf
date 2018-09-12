library plato.crf.factory.course;

import 'dart:html' show window;

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
    window.console.debug (rawCourse);
    if (!(rawCourse.containsKey ('courseId') &&
          rawCourse.containsKey ('title'))) {
      throw new CourseException();
    }

    return new Course (rawCourse['courseId'], rawCourse['title']);
  }

  /// The [createAll] method...
  @override
  List<Course> createAll (covariant Iterable<Map<String, dynamic>> rawCourses) {
    var courses = new List<Course>();

    window.console.debug (rawCourses);
    try {
      rawCourses.forEach (
        (Map rawCourse) => courses.add (create (rawCourse.cast()))
      );
    } catch (_) {
      window.console.log (_.toString());
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
    var rejectedCourses = new List<RejectedCourse>();

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
