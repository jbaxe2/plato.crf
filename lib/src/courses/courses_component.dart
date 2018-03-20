library plato.angular.components.course.courses;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../sections/sections_service.dart';

import 'course.dart';
import 'courses_service.dart';

/// The [CoursesComponent] component class...
@Component(
  selector: 'courses',
  templateUrl: 'courses_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [CoursesService, SectionsService],
)
class CoursesComponent implements OnInit {
  List<Course> courses;

  Course selectedCourse;

  final CoursesService coursesService;

  final SectionsService sectionsService;

  String selectorText;

  /// The [CoursesComponent] constructor...
  CoursesComponent (this.coursesService, this.sectionsService) {
    courses = new List<Course>();
    selectorText = 'Select a course...';
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (courses = coursesService.courses);

  /// The [onCourseSelected] method...
  void onCourseSelected (Course aCourse) {
    selectedCourse = aCourse;
    selectorText = selectedCourse.title;

    sectionsService.setCourseId (selectedCourse.id);
  }
}
