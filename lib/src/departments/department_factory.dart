library plato.crf.factory.department;

import '../_application/factory/plato_factory.dart';

import 'department.dart';
import 'department_exception.dart';

/// The [DepartmentFactory] class...
class DepartmentFactory implements PlatoFactory<Department> {
  /// The [DepartmentFactory] default constructor...
  DepartmentFactory();

  /// The [create] method...
  @override
  Department create (Map<String, dynamic> rawDepartment) {
    if (!(rawDepartment.containsKey ('code') &&
          rawDepartment.containsKey ('description'))) {
      throw new DepartmentException (
        'The provided department information was improperly formatted.'
      );
    }

    return new Department (rawDepartment['code'], rawDepartment['description']);
  }

  /// The [createAll] method...
  @override
  List<Department> createAll (Iterable<Map<String, dynamic>> rawDepartments) {
    var departments = new List<Department>();

    try {
      rawDepartments.forEach ((Map<String, dynamic> rawDepartment) {
        departments.add (create (rawDepartment));
      });
    } catch (_) {
      rethrow;
    }

    return departments;
  }
}
