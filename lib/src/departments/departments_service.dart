library plato.crf.services.departments;

import 'dart:async' show Future;
import 'dart:convert' show json, utf8;

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

  static final DepartmentFactory _departmentFactory = new DepartmentFactory();

  final Client _http;

  static DepartmentsService _instance;

  /// The [DepartmentsService] factory constructor...
  factory DepartmentsService (Client http) =>
    _instance ?? (_instance = new DepartmentsService._ (http));

  /// The [DepartmentsService] private constructor...
  DepartmentsService._ (this._http) {
    departments = new List<Department>();
  }

  /// The [retrieveDepartments] method...
  Future retrieveDepartments() async {
    try {
      final Response deptsResponse = await _http.get (_DEPTS_URI);

      List rawDepts =
        (json.decode (utf8.decode (deptsResponse.bodyBytes)) as Map)['departments'];

      departments
        ..clear()
        ..addAll (_departmentFactory.createAll (rawDepts.cast()));
    } catch (_) {
      throw new DepartmentException ('Unable to retrieve the departments list.');
    }
  }
}
