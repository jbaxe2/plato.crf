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
  providers: const [CoursesService],
)
class DepartmentsComponent implements OnInit {
  final CoursesService deptsService;

  List<Department> departments;

  Department selectedDepartment;

  /// The [DepartmentsComponent] constructor...
  DepartmentsComponent (this.deptsService);

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    departments = await deptsService.retrieveDepartments();
  }

  /// The [onDepartmentSelected] method...
  Future<Null> onDepartmentSelected() async {}
}
