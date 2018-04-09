@TestOn('browser')

library plato.angular.tests;

import 'package:test/test.dart';

import 'course_request/course_request_test.dart';

/// The [main] function...
void main() {
  test ('Testing the course request class functionality.',
    () {
      expect (testCourseRequest(), true);
    }
  );
}
