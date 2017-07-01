library plato.angular.components.banner.departments;

import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import 'departments_service.dart';
import 'department.dart';

/// The [DepartmentsComponent] component class...
@Component(
  selector: 'departments',
  //styleUrls: const ['departments_component.css'],
  templateUrl: 'departments_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [DepartmentsService],
)
class DepartmentsComponent implements OnInit {
  final DepartmentsService deptsService;

  List<Department> departments;

  /// The [DepartmentsComponent] constructor...
  DepartmentsComponent (this.deptsService);

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    departments = await deptsService.loadDepartments();
  }

  /// The [onDepartmentSelected] method...
  Future<Null> onDepartmentSelected() async {}
}
