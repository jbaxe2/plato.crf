@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests;

import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';

import 'package:test/test.dart';

import 'course_request/course_request_test.dart' as course_request;

/// The [main] function...
@AngularEntrypoint()
void main() {
  tearDown (disposeAnyRunningTest);

  course_request.main();
}
