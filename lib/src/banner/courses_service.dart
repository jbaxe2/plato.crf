library plato.angular.services.banner.courses;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart';

import '../error/banner_exception.dart';

import 'course.dart';

const String _COURSES_URI = '/plato/retrieve/courses';

/// The [CoursesService] class...
@Injectable()
class CoursesService {
  String departmentId;

  String termId;

  List<Course> courses;

  final Client _http;

  /// The [CoursesService] constructor...
  CoursesService (this._http) {
    courses = new List<Course>();
  }

  /// The [retrieveCourses] method...
  Future retrieveCourses() async {
    try {
      final Response coursesResponse = await _http.get (
        '$_COURSES_URI?dept=$departmentId&term=$termId'
      );

      List<Map<String, String>> rawCourses =
        (JSON.decode (coursesResponse.body) as Map)['courses'];

      rawCourses.forEach ((Map<String, String> rawCourse) {
        courses.add (new Course (rawCourse['courseId'], rawCourse['title']));
      });
    } catch (_) {
      throw new BannerException ('Unable to retrieve the courses list.');
    }
  }
}
