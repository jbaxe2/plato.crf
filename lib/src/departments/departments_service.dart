library plato.angular.services.banner.departments;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import 'package:plato_angular/src/banner/banner_exception.dart';

import 'package:plato_angular/src/departments/department.dart';

const String _DEPTS_URI = '/plato/retrieve/departments';

/// The [DepartmentsService] class...
@Injectable()
class DepartmentsService {
  List<Department> departments;

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

      List<Map<String, String>> rawDepts =
        (JSON.decode (deptsResponse.body) as Map)['departments'];

      departments.clear();

      rawDepts.forEach ((Map<String, String> rawDept) {
        departments.add (new Department (rawDept['code'], rawDept['description']));
      });
    } catch (_) {
      throw new BannerException ('Unable to retrieve the departments list.');
    }
  }
}