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

/// The [main] function...
void main() {
  NgTestFixture<DepartmentsComponent> deptsFixture;
  DepartmentsPO deptsPo;

  var deptsTestBed = new NgTestBed<DepartmentsComponent>().addProviders (
    [provide (Client, useClass: MockDepartmentsClient), DepartmentsService]
  );

  setUp (() async {
    deptsFixture = await deptsTestBed.create();
    deptsPo = await deptsFixture.resolvePageObject (DepartmentsPO);
  });

  tearDown (disposeAnyRunningTest);

  testDepartmentsComponent (deptsPo);
}

/// The [testDepartmentsComponent] function...
void testDepartmentsComponent (DepartmentsPO deptsPo) {
  ;
}
