library plato.angular.components.banner.sections.requesting;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../banner/departments_component.dart';
import '../banner/courses_component.dart';
import '../banner/sections_selection_component.dart';

import '../learn/terms_component.dart';

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
