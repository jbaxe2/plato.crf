library plato.angular.components.banner.courses;

import 'dart:async';

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
class CoursesComponent implements OnInit {
  final CoursesService coursesService;

  List<Course> courses;

  Course selectedCourse;

  /// The [CoursesComponent] constructor...
  CoursesComponent (this.coursesService);

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    courses = new List<Course>();
  }

  /// The [onCourseSelected] method...
  Future<Null> onCourseSelected() async {}
}
