library plato.crf.services.courses;

import 'dart:async' show Future;
import 'dart:convert' show json, utf8;

import 'package:http/http.dart' show Client, Response;

import 'course.dart';
import 'course_exception.dart';
import 'course_factory.dart';

const String _COURSES_URI = '/plato/retrieve/courses';

/// The [CoursesService] class...
class CoursesService {
  String _departmentId;

  String _termId;

  List<Course> courses;

  static final CourseFactory _courseFactory = new CourseFactory();

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
  void setDepartmentId (String departmentId) {
    if (departmentId == _departmentId) {
      return;
    }

    _departmentId = departmentId;

    if (null != _termId) {
      _retrieveCourses();
    }
  }

  /// The [setTermId] method...
  void setTermId (String termId) {
    if (termId == _termId) {
      return;
    }

    _termId = termId;

    if (null != _departmentId) {
      _retrieveCourses();
    }
  }

  /// The [_retrieveCourses] method...
  Future<void> _retrieveCourses() async {
    try {
      final Response coursesResponse = await _http.get (
        '$_COURSES_URI?dept=$_departmentId&term=$_termId'
      );

      String decodedResponse = utf8.decode (coursesResponse.bodyBytes);
      List rawCourses = (json.decode (decodedResponse) as Map)['courses'];

      courses
        ..clear()
        ..addAll (_courseFactory.createAll (rawCourses.cast()));
    } catch (_) {
      throw new CourseException ('Unable to retrieve the courses list.');
    }
  }
}
