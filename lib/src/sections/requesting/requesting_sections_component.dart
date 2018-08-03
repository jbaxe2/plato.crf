library plato.crf.components.sections.requesting;

import 'package:angular/angular.dart';

import '../../courses/courses_component.dart';

import '../../departments/departments_component.dart';

import '../../terms/terms_component.dart';

import '../selection/sections_selection_component.dart';

@Component(
  selector: 'requesting-sections',
  templateUrl: 'requesting_sections_component.html',
  directives: const [
    DepartmentsComponent, TermsComponent, CoursesComponent,
    SectionsSelectionComponent
  ]
)
class RequestingSectionsComponent {}
