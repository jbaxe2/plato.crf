library plato.crf.tests.components.po.departments;

import 'dart:async' show Future;

import 'package:pageloader/pageloader.dart';

import 'package:plato.crf/src/departments/department.dart';

// ignore: uri_has_not_been_generated
part 'departments_po.g.dart';

/// The [DepartmentsPO] class...
@PageObject()
abstract class DepartmentsPO {
  @ByTagName('material-select-item')
  List<PageLoaderElement> get _departments;

  Future<List<Department>> departments;

  /// The [DepartmentsPO] constructor...
  DepartmentsPO();

  /// The [DepartmentsPO] factory constructor...
  // ignore: redirect_to_non_class
  factory DepartmentsPO.create (PageLoaderElement context) = $DepartmentsPo.create;

  /// The [initDeptsPO] method...
  Future<void> initDeptsPO() async {
    departments = _deptsFromSelectItems();
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
