library plato.angular.components.banner.departments;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'department.dart';

import 'courses_service.dart';
import 'departments_service.dart';

/// The [DepartmentsComponent] component class...
@Component(
  selector: 'departments',
  templateUrl: 'departments_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [DepartmentsService, CoursesService],
)
class DepartmentsComponent implements OnInit {
  List<Department> departments;

  Department selectedDepartment;

  final DepartmentsService deptsService;

  final CoursesService coursesService;

  /// The [DepartmentsComponent] constructor...
  DepartmentsComponent (this.deptsService, this.coursesService) {
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

    coursesService.setDepartmentId (selectedDepartment.code);
  }
}
