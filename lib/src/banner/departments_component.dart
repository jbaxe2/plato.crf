library plato.angular.components.banner.departments;

import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import 'departments_service.dart';
import 'department.dart';

/// The [DepartmentsComponent] class...
@Component(
  selector: 'departments',
  styleUrls: const ['departments_component.css'],
  templateUrl: 'departments_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, DepartmentsService],
)
class DepartmentsComponent implements OnInit {
  final DepartmentsService deptsService;

  List<Department> departments;

  DepartmentsComponent (this.deptsService);

  @override
  Future ngOnInit() async {
    departments = await deptsService.loadDepartments();
  }
}
