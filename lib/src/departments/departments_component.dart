library plato.crf.components.departments;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../courses/courses_service.dart';

import 'department.dart';
import 'departments_service.dart';

/// The [DepartmentsComponent] component class...
@Component(
  selector: 'departments',
  templateUrl: 'departments_component.html',
  styleUrls: const ['departments_component.css'],
  directives: const [
    MaterialDropdownSelectComponent, MaterialSelectItemComponent, NgFor
  ],
  providers: const [DepartmentsService, CoursesService],
)
class DepartmentsComponent implements OnInit {
  List<Department> departments;

  Department selectedDepartment;

  final DepartmentsService deptsService;

  final CoursesService coursesService;

  String selectorText;

  /// The [DepartmentsComponent] constructor...
  DepartmentsComponent (this.deptsService, this.coursesService) {
    departments = new List<Department>();
    selectorText = 'Select a department...';
  }

  /// The [ngOnInit] method...
  @override
  Future<void> ngOnInit() async {
    try {
      if (deptsService.departments.isEmpty) {
        await deptsService.retrieveDepartments();
      }

      departments = deptsService.departments;
    } catch (_) {}
  }

  /// The [onDepartmentSelected] method...
  void onDepartmentSelected (Department aDepartment) {
    selectedDepartment = aDepartment;
    selectorText = selectedDepartment.description;

    coursesService.setDepartmentId (selectedDepartment.code);
  }
}
