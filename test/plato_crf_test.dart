@TestOn('browser')
library plato.crf.tests;

import 'package:angular_test/angular_test.dart';

import 'package:test/test.dart';

import 'components/departments_component_test.dart' as departments_component;

import 'services/courses_service_test.dart' as courses_service;
import 'services/departments_service_test.dart' as departments_service;
import 'services/previous_content_service_test.dart' as previous_content_service;
import 'services/terms_service_test.dart' as terms_service;

import 'course_request_test.dart' as course_request;
import 'cross_listing_test.dart' as cross_listing;

import 'testable.dart';

/// The [main] function...
void main() => (new PlatoCourseRequestFormTester()).run();

/// The [PlatoCourseRequestFormTester] class...
class PlatoCourseRequestFormTester implements Testable {
  /// The [PlatoCourseRequestFormTester] constructor...
  PlatoCourseRequestFormTester();

  /// The [run] method...
  @override
  void run() {
    tearDown (disposeAnyRunningTest);

    _testDomain();
    _testServices();
    _testComponents();
  }

  /// The [_testDomain] method...
  void _testDomain() {
    course_request.main();
    cross_listing.main();
  }

  /// The [_testServices] method...
  void _testServices() {
    departments_service.main();
    terms_service.main();
    courses_service.main();
    previous_content_service.main();
  }

  /// The [_testComponents] method...
  void _testComponents() {
    departments_component.main();
  }
}
