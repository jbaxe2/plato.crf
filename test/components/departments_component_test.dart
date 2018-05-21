@TestOn('browser')
library plato.crf.tests.components.departments;

import 'package:angular/core.dart';
import 'package:angular_test/angular_test.dart';
import 'package:http/http.dart' show Client;
import 'package:test/test.dart';

import 'package:plato_crf/src/courses/courses_service.dart';

import 'package:plato_crf/src/departments/departments_component.dart';
import 'package:plato_crf/src/departments/departments_service.dart';

import '../services/mock_client/mock_departments_client.dart';

import 'departments_po.dart';

// ignore: uri_has_not_been_generated
import 'package:plato_crf/src/departments/departments_component.template.dart' as dc;

// ignore: uri_has_not_been_generated
import 'departments_component_test.template.dart' as dct;

NgTestFixture<DepartmentsComponent> deptsFixture;
DepartmentsPO deptsPo;

@GenerateInjector([
  const ClassProvider (Client, useClass: MockDepartmentsClient),
  const ClassProvider (DepartmentsService),
  const ClassProvider (CoursesService)
])
final deptsInjector = dct.deptsInjector$Injector;

/// The [main] function...
void main() {
  final deptsTestBed = NgTestBed.forComponent<DepartmentsComponent> (
    dc.DepartmentsComponentNgFactory, rootInjector: deptsInjector
  );

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
