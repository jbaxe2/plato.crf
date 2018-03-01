library plato.angular.services.banner.courses;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular2/core.dart';

import 'package:http/http.dart';

import 'course.dart';

const String _COURSES_URI = '/plato/retrieve/courses';

/// The [CoursesService] class...
@Injectable()
class CoursesService {
  List<Course> courses;

  final Client _http;

  /// The [CoursesService] constructor...
  CoursesService (this._http) {
    courses = new List<Course>();
  }

  /// The [loadCourses] method...
  Future<List<Course>> loadCourses (String deptId, String termId) async {
    try {
      final Response coursesResponse = await _http.get (
        '$_COURSES_URI?dept=$deptId&term=$termId'
      );

      List<Map<String, String>> rawCourses =
        (JSON.decode (coursesResponse.body) as Map)['departments'];

      rawCourses.forEach ((Map<String, String> rawCourse) {
        courses.add (new Course (rawCourse['courseId'], rawCourse['title']));
      });
    } catch (_) {
      print (_.toString());
    }

    return courses;
  }
}
