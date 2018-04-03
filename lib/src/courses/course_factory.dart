library plato.angular.factory.course;

import '../_application/factory/plato_factory.dart';

import 'course.dart';
import 'course_exception.dart';

/// The [CourseFactory] class...
class CourseFactory implements PlatoFactory<Course> {
  /// The [CourseFactory] default constructor...
  CourseFactory();

  /// The [create] method...
  @override
  Course create (Map<String, dynamic> rawCourse) {
    if (!(rawCourse.containsKey ('courseId') &&
          rawCourse.containsKey ('title'))) {
      throw new CourseException();
    }

    return new Course (rawCourse['courseId'], rawCourse['title']);
  }

  /// The [createAll] method...
  @override
  List<Course> createAll (Iterable<Map<String, dynamic>> rawCourses) {
    var courses = new List<Course>();

    try {
      rawCourses.forEach (
        (Map<String, dynamic> rawCourse) => courses.add (create (rawCourse))
      );
    } catch (_) {
      rethrow;
    }

    return courses;
  }
}
