library plato.angular.course_request;

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'course-request',
  templateUrl: 'course_request.html',
  directives: const [materialDirectives],
  providers: const [materialProviders],
)
class CourseRequest {}
