library plato.angular.tests.components.po.departments;

import 'dart:async' show Future;

import 'package:pageloader/objects.dart';

import 'package:plato_angular/src/departments/department.dart';

/// The [DepartmentsPO] class...
class DepartmentsPO {
  @ByTagName('material-select-item')
  List<PageLoaderElement> _departments;

  Future<List<Department>> departments;

  /// The [DepartmentsPO] constructor...
  DepartmentsPO();

  Department _deptsFromSelectItems (String code) {
    return new Department ('', '');
  }
}
