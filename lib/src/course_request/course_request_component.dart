library plato.crf.components.course_request;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/laminate/popup/module.dart';
import 'package:angular_components/utils/browser/dom_service/angular_2.dart';
import 'package:angular_components/utils/angular/scroll_host/angular_2.dart';

import '../_application/error/error_component.dart';
import '../_application/progress/progress_component.dart';
import '../_application/session_cleanup/session_cleanup_component.dart';
import '../_application/submission_response/submission_response_component.dart';
import '../_application/workflow/workflow_component.dart';

import '../sections/requested/requested_sections_component.dart';

import 'course_request_service.dart';

/// The [CourseRequestComponent] component class...
@Component(
  selector: 'course-request',
  templateUrl: 'course_request_component.html',
  styleUrls: const [
    'course_request_component.css'
  ],
  directives: const [
    ErrorComponent, ProgressComponent, RequestedSectionsComponent,
    SubmissionResponseComponent, SessionCleanupComponent, WorkflowComponent,
    NgIf
  ],
  providers: const [
    materialProviders, domServiceBinding, scrollHostProviders,
    CourseRequestService
  ]
)
class CourseRequestComponent {
  bool get submittable => _crfService.submittable;

  final CourseRequestService _crfService;

  /// The [CourseRequestComponent] constructor...
  CourseRequestComponent (this._crfService);

  /// The [reviewCourseRequest] method...
  void reviewCourseRequest() => _crfService.reviewCourseRequest();
}
