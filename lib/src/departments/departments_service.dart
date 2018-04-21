library plato.angular.services.departments;

import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import 'department.dart';
import 'department_exception.dart';
import 'department_factory.dart';

const String _DEPTS_URI = '/plato/retrieve/departments';

/// The [DepartmentsService] class...
@Injectable()
class DepartmentsService {
  List<Department> departments;

  DepartmentFactory _departmentFactory;

  final Client _http;

  static DepartmentsService _instance;

  /// The [DepartmentsService] factory constructor...
  factory DepartmentsService (Client http) =>
    _instance ?? (_instance = new DepartmentsService._ (http));

  /// The [DepartmentsService] private constructor...
  DepartmentsService._ (this._http) {
    departments = new List<Department>();
    _departmentFactory = new DepartmentFactory();
  }

  /// The [retrieveDepartments] method...
  Future retrieveDepartments() async {
    try {
      final Response deptsResponse = await _http.get (_DEPTS_URI);

      List<Map<String, String>> rawDepts =
        (json.decode (deptsResponse.body) as Map)['departments'];

      departments
        ..clear()
        ..addAll (_departmentFactory.createAll (rawDepts));
    } catch (_) {
      throw new DepartmentException ('Unable to retrieve the departments list.');
    }
  }
}
