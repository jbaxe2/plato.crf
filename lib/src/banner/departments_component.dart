library plato.angular.components.banner.departments;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'department.dart';

import 'departments_service.dart';

/// The [DepartmentsComponent] component class...
@Component(
  selector: 'departments',
  templateUrl: 'departments_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [DepartmentsService],
)
class DepartmentsComponent implements OnInit {
  List<Department> departments;

  Department selectedDepartment;

  final DepartmentsService deptsService;

  /// The [DepartmentsComponent] constructor...
  DepartmentsComponent (this.deptsService) {
    departments = new List<Department>();
  }

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    await deptsService.retrieveDepartments();

    departments = deptsService.departments;
  }

  /// The [onDepartmentSelected] method...
  void onDepartmentSelected (Department aDepartment) {
    selectedDepartment = aDepartment;
  }
}
