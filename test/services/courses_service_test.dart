@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests.services.courses;

import 'dart:async' show Future;

import 'package:test/test.dart';

import 'package:plato_angular/src/courses/courses_service.dart';

import 'mock_client/mock_courses_client.dart';

var _http = new MockCoursesClient();

/// The [main] function...
void main() {
  group (
    'Courses service:',
    () {
      testTwoCoursesServiceReferencesAreSame();
      testRetrieveCourses();
      testRetrieveCourseForWrongDeptId();
      testRetrieveCourseForWrongTermId();
    }
  );
}

/// The [testTwoCoursesServiceReferencesAreSame] function...
void testTwoCoursesServiceReferencesAreSame() {
  test (
    'Confirm that two courses service instance references are the same object.',
    () {
      var coursesService1 = new CoursesService (_http);
      var coursesService2 = new CoursesService (_http);

      expect ((identical (coursesService1, coursesService2)), true);
    }
  );
}

/// The [testRetrieveCourses] function...
void testRetrieveCourses() {
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

/// The [testRetrieveCourseForWrongDeptId] function...
void testRetrieveCourseForWrongDeptId() {
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

/// The [testRetrieveCourseForWrongTermId] function...
void testRetrieveCourseForWrongTermId() {
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
