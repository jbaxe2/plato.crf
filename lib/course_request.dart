library plato.angular.course_request;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/banner/departments_component.dart';
import 'src/banner/courses_component.dart';
import 'src/banner/sections_selection_component.dart';

import 'src/learn/terms_component.dart';

/// The [CourseRequest] component class...
@Component(
  selector: 'course-request',
  templateUrl: 'course_request.html',
  directives: const [
    COMMON_DIRECTIVES, materialDirectives,
    DepartmentsComponent, TermsComponent, CoursesComponent,
    SectionsSelectionComponent
  ],
  providers: const [materialProviders],
)
class CourseRequest {}
