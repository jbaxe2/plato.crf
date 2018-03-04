library plato.angular.course_request;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/crf/requesting_sections_component.dart';

/// The [CourseRequestComponent] component class...
@Component(
  selector: 'course-request',
  templateUrl: 'course_request_component.html',
  directives: const [
    COMMON_DIRECTIVES, materialDirectives,
    RequestingSectionsComponent
  ],
  providers: const [materialProviders],
)
class CourseRequestComponent {}
