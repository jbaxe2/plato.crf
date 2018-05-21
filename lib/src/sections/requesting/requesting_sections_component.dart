library plato.crf.components.sections.requesting;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../courses/courses_component.dart';

import '../../departments/departments_component.dart';

import '../../terms/terms_component.dart';

import '../selection/sections_selection_component.dart';

@Component(
  selector: 'requesting-sections',
  templateUrl: 'requesting_sections_component.html',
  directives: const [
    coreDirectives, materialDirectives,
    DepartmentsComponent, TermsComponent, CoursesComponent,
    SectionsSelectionComponent
  ],
  providers: const [materialProviders]
)
class RequestingSectionsComponent {}
