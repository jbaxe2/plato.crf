library plato.angular.components.banner.courses;

//import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'course.dart';

import 'courses_service.dart';

/// The [CoursesComponent] component class...
@Component(
  selector: 'courses',
  templateUrl: 'courses_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [CoursesService],
)
class CoursesComponent {
  final CoursesService coursesService;

  List<Course> courses;

  Course selectedCourse;

  @Input()
  String departmentId;

  @Input()
  String termId;

  /// The [CoursesComponent] constructor...
  CoursesComponent (this.coursesService) {
    courses = new List<Course>();
  }

  /// The [onCourseSelected] method...
  void onCourseSelected (Course aCourse) {
    selectedCourse = aCourse;
  }
}
