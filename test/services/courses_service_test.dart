@TestOn('browser')
library plato.crf.tests.services.courses;

import 'dart:async' show Future;

import 'package:test/test.dart';

import 'package:plato.crf/src/courses/courses_service.dart';

import '../testable.dart';

import 'mock_client/mock_courses_client.dart';

var _http = new MockCoursesClient();

/// The [main] function...
void main() => (new CoursesServiceTester()).run();

/// The [CoursesServiceTester] class...
class CoursesServiceTester implements Testable {
  /// The [CoursesServiceTester] constructor...
  CoursesServiceTester();

  /// The [run] method...
  @override
  void run() {
    group (
      'Courses service:',
      () {
        _testTwoCoursesServiceReferencesAreSame();
        _testRetrieveCourses();
        _testRetrieveCourseForWrongDeptId();
        _testRetrieveCourseForWrongTermId();
      }
    );
  }

  /// The [_testTwoCoursesServiceReferencesAreSame] method...
  void _testTwoCoursesServiceReferencesAreSame() {
    test (
      'Confirm that two courses service instance references are the same object.',
      () {
        var coursesService1 = new CoursesService (_http);
        var coursesService2 = new CoursesService (_http);

        expect ((identical (coursesService1, coursesService2)), true);
      }
    );
  }

  /// The [_testRetrieveCourses] method...
  void _testRetrieveCourses() {
    test (
      'Retrieve the list of courses from the server.',
      () async {
        var coursesService = new CoursesService (_http)
          ..setDepartmentId ('CAIS')
          ..setTermId ('2018fall');

        await new Future (() {
          expect ((0 < coursesService.courses.length), true);
        });
      }
    );
  }

  /// The [_testRetrieveCourseForWrongDeptId] method...
  void _testRetrieveCourseForWrongDeptId() {
    test (
      'Retrieve empty list of courses for a wrong department ID.',
      () async {
        var coursesService = new CoursesService (_http)
          ..setDepartmentId ('ART')
          ..setTermId ('2018fall');

        await new Future (() {
          expect ((0 == coursesService.courses.length), true);
        });
      }
    );
  }

  /// The [_testRetrieveCourseForWrongTermId] method...
  void _testRetrieveCourseForWrongTermId() {
    test (
      'Retrieve empty list of courses for a wrong term ID.',
      () async {
        var coursesService = new CoursesService (_http)
          ..setDepartmentId ('CAIS')
          ..setTermId ('2018spring');

        await new Future (() {
          expect ((0 == coursesService.courses.length), true);
        });
      }
    );
  }
}
