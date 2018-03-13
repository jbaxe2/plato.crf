library plato.angular.course_request;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/banner/requesting_sections_component.dart';

import 'src/crf/course_request_service.dart';
import 'src/crf/error_component.dart';
import 'src/crf/requested_sections_component.dart';

import 'src/learn/cross_listings_component.dart';

import 'src/user/user_component.dart';

/// The [CourseRequestComponent] component class...
@Component(
  selector: 'course-request',
  templateUrl: 'course_request_component.html',
  styleUrls: const [
    'package:angular_components/app_layout/layout.scss.css'
  ],
  directives: const [
    COMMON_DIRECTIVES, materialDirectives,
    UserComponent, RequestingSectionsComponent, RequestedSectionsComponent,
    CrossListingsComponent,
    ErrorComponent
  ],
  providers: const [materialProviders, CourseRequestService],
)
class CourseRequestComponent {
  final CourseRequestService crfService;

  /// The [CourseRequestComponent] constructor...
  CourseRequestComponent (this.crfService);
}
