@TestOn('browser')
library plato.angular.tests.services.departments;

import 'package:test/test.dart';

import 'package:plato_angular/src/departments/departments_service.dart';

import 'mock_client/mock_departments_client.dart';

var _http = new MockDepartmentsClient();

/// The [main] function...
void main() {
  group (
    'Departments service:',
    () {
      testTwoDepartmentsServiceReferencesAreSame();
      testRetrieveDepartments();
    }
  );
}

/// The [testTwoDepartmentsServiceReferencesAreSame] function...
void testTwoDepartmentsServiceReferencesAreSame() {
  test (
    'Confirm that two departments service instance references are the same object.',
    () {
      var deptsService1 = new DepartmentsService (_http);
      var deptsService2 = new DepartmentsService (_http);

      expect ((identical (deptsService1, deptsService2)), true);
    }
  );
}

/// The [testRetrieveDepartments] function...
void testRetrieveDepartments() {
  test (
    'Retrieve the list of departments from the server.', () async {
      var deptsService = new DepartmentsService (_http);
      await deptsService.retrieveDepartments();

      expect ((0 < deptsService.departments.length), true);
    }
  );
}
