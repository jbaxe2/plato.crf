library plato.angular.components.application.review;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../course_request/course_request_service.dart';
import '../../course_request/request_information.dart';

/// The [ReviewRequestComponent] class...
@Component(
  selector: 'review-request',
  templateUrl: 'review_request_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [CourseRequestService]
)
class ReviewRequestComponent implements OnInit {
  bool isVisible;

  RequestInformation requestInformation;

  final CourseRequestService _crfService;

  /// The [ReviewRequestComponent] constructor...
  ReviewRequestComponent (this._crfService);

  /// The [ngOnInit] method...
  void ngOnInit() {
    requestInformation = new RequestInformation();
    isVisible = false;
  }

  /// The [submitCrf] method...
  void submitCrf() {
    try {
      _crfService.submitCourseRequest();
    } catch (_) {}
  }
}
