@TestOn('browser')
library plato.crf.tests;

import 'package:angular_test/angular_test.dart';

import 'package:test/test.dart';

//import 'components/departments_component_test.dart';

import 'services/courses_service_test.dart';
import 'services/departments_service_test.dart';
import 'services/previous_content_service_test.dart';
import 'services/terms_service_test.dart';

import 'course_request_test.dart';
import 'cross_listing_test.dart';

import 'testable.dart';

// ignore: uri_has_not_been_generated
import 'plato_crf_test.template.dart' as pct;

/// The [main] function...
void main() {
  pct.initReflector();

  (new PlatoCourseRequestFormTester()).run();
}

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
    (new CourseRequestTester()).run();
    (new CrossListingTester()).run();
  }

  /// The [_testServices] method...
  void _testServices() {
    (new DepartmentsServiceTester()).run();
    (new TermsServiceTester()).run();
    (new CoursesServiceTester()).run();
    (new PreviousContentServiceTester()).run();
  }

  /// The [_testComponents] method...
  void _testComponents() {
    //(new DepartmentsComponentTester()).run();
  }
}
