@TestOn('browser')
library plato.crf.tests.services.departments;

import 'package:test/test.dart';

import 'package:plato_crf/src/departments/departments_service.dart';

import '../testable.dart';

import 'mock_client/mock_departments_client.dart';

var _http = new MockDepartmentsClient();

/// The [main] function...
void main() => (new DepartmentsServiceTester()).run();

/// The [DepartmentsServiceTester] class...
class DepartmentsServiceTester implements Testable {
  /// The [DepartmentsServiceTester] constructor...
  DepartmentsServiceTester();

  /// The [run] method...
  @override
  void run() {
    group (
      'Departments service:',
      () {
        _testTwoDepartmentsServiceReferencesAreSame();
        _testRetrieveDepartments();
      }
    );
  }

  /// The [_testTwoDepartmentsServiceReferencesAreSame] method...
  void _testTwoDepartmentsServiceReferencesAreSame() {
    test (
      'Confirm that two departments service instance references are the same object.',
      () {
        var deptsService1 = new DepartmentsService (_http);
        var deptsService2 = new DepartmentsService (_http);

        expect ((identical (deptsService1, deptsService2)), true);
      }
    );
  }

  /// The [_testRetrieveDepartments] method...
  void _testRetrieveDepartments() {
    test (
      'Retrieve the list of departments from the server.',
      () async {
        var deptsService = new DepartmentsService (_http);
        await deptsService.retrieveDepartments();

        expect ((0 < deptsService.departments.length), true);
      }
    );
  }
}
