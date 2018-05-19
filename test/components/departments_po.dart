library plato.angular.tests.components.po.departments;

import 'dart:async' show Future;

import 'package:pageloader/objects.dart';

import 'package:plato_crf/src/departments/department.dart';

/// The [DepartmentsPO] class...
class DepartmentsPO {
  @ByTagName('material-select-item')
  List<PageLoaderElement> _departments;

  Future<List<Department>> departments;

  /// The [DepartmentsPO] constructor...
  DepartmentsPO() {
    () async => (departments = _deptsFromSelectItems());
  }

  /// The [_deptsFromSelectItems] method...
  Future<List<Department>> _deptsFromSelectItems() async {
    var depts = new List<Department>();

    await Future.forEach (_departments, (PageLoaderElement deptEl) async {
      String deptText = (await deptEl.visibleText).trim();
      List<String> deptTextParts = deptText.split (' ');

      var department = new Department (
        deptTextParts.first.substring (1, (deptTextParts.first.length - 1)),
        deptTextParts.sublist (1).join (' ')
      );

      depts.add (department);
    });

    return depts;
  }
}
