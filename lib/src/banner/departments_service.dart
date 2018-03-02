library plato.angular.services.banner.departments;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart';

import '../error/banner_exception.dart';

import 'department.dart';

const String _DEPTS_URI = '/plato/retrieve/departments';

/// The [DepartmentsService] class...
@Injectable()
class DepartmentsService {
  List<Department> departments;

  final Client _http;

  /// The [DepartmentsService] constructor...
  DepartmentsService (this._http) {
    departments = new List<Department>();
  }

  /// The [retrieveDepartments] method...
  Future retrieveDepartments() async {
    try {
      final Response deptsResponse = await _http.get (_DEPTS_URI);

      List<Map<String, String>> rawDepts =
        (JSON.decode (deptsResponse.body) as Map)['departments'];

      rawDepts.forEach ((Map<String, String> rawDept) {
        departments.add (new Department (rawDept['code'], rawDept['description']));
      });
    } catch (_) {
      throw new BannerException ('Unable to retrieve the departments list.');
    }
  }
}
