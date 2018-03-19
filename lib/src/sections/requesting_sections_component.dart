library plato.angular.components.banner.sections.requesting;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato_angular/src/departments/departments_component.dart';
import 'package:plato_angular/src/course/courses_component.dart';
import 'package:plato_angular/src/sections/sections_selection_component.dart';

import 'package:plato_angular/src/terms/terms_component.dart';

@Component(
  selector: 'requesting-sections',
  templateUrl: 'requesting_sections_component.html',
  directives: const [
    CORE_DIRECTIVES, materialDirectives,
    DepartmentsComponent, TermsComponent, CoursesComponent,
    SectionsSelectionComponent
  ],
  providers: const [materialProviders]
)
class RequestingSectionsComponent {}
