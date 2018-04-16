@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests.components.departments;

import 'package:angular/core.dart';
import 'package:angular_test/angular_test.dart';
import 'package:http/http.dart' show Client;
import 'package:test/test.dart';

import 'package:plato_angular/src/departments/departments_component.dart';
import 'package:plato_angular/src/departments/departments_service.dart';

import '../services/mock_client/mock_departments_client.dart';

import 'departments_po.dart';

NgTestFixture<DepartmentsComponent> deptsFixture;
DepartmentsPO deptsPo;

/// The [main] function...
void main() {
  final deptsTestBed = new NgTestBed<DepartmentsComponent>().addProviders ([
    provide (Client, useClass: MockDepartmentsClient),
    DepartmentsService
  ]);

  setUp (() async {
    deptsFixture = await deptsTestBed.create();
    //deptsPo = await deptsFixture.resolvePageObject (DepartmentsPO);
  });

  tearDown (disposeAnyRunningTest);

  group (
    'Departments component:', () {
      testDepartmentsComponent();
    }
  );
}

/// The [testDepartmentsComponent] function...
void testDepartmentsComponent() {
  test (
    'Departments in the component are loaded successfully.', () async {
      expect ((0 < (await deptsPo.departments).length), true);
    }
  );
}
