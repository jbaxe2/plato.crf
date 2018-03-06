library plato.angular.services.banner.courses;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import 'package:plato_angular/src/banner/banner_exception.dart';

import 'course.dart';

const String _COURSES_URI = '/plato/retrieve/courses';

/// The [CoursesService] class...
@Injectable()
class CoursesService {
  String _departmentId;

  String _termId;

  List<Course> courses;

  final Client _http;

  static CoursesService _instance;

  /// The [CoursesService] factory constructor...
  factory CoursesService (Client http) =>
    _instance ?? (_instance = new CoursesService._ (http));

  /// The [CoursesService] private constructor...
  CoursesService._ (this._http) {
    courses = new List<Course>();
  }

  /// The [setDepartmentId] method...
  Future setDepartmentId (String departmentId) async {
    _departmentId = departmentId;

    if (null != _termId) {
      retrieveCourses();
    }
  }

  /// The [setTermId] method...
  Future setTermId (String termId) async {
    _termId = termId;

    if (null != _departmentId) {
      retrieveCourses();
    }
  }

  /// The [retrieveCourses] method...
  Future retrieveCourses() async {
    try {
      final Response coursesResponse = await _http.get (
        '$_COURSES_URI?dept=$_departmentId&term=$_termId'
      );

      List<Map<String, String>> rawCourses =
        (JSON.decode (coursesResponse.body) as Map)['courses'];

      courses.clear();

      rawCourses.forEach ((Map<String, String> rawCourse) {
        courses.add (new Course (rawCourse['courseId'], rawCourse['title']));
      });
    } catch (_) {
      throw new BannerException ('Unable to retrieve the courses list.');
    }
  }
}
