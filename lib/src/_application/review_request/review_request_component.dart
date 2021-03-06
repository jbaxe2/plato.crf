library plato.crf.components.application.review;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../course_request/course_request_service.dart';
import '../../course_request/course_request.dart';

import '../progress/progress_service.dart';

/// The [ReviewRequestComponent] class...
@Component(
  selector: 'review-request',
  templateUrl: 'review_request_component.html',
  styleUrls: ['review_request_component.css'],
  directives: [
    MaterialButtonComponent, MaterialExpansionPanel, MaterialIconComponent,
    MaterialListComponent, MaterialListItemComponent,
    NgIf, NgFor
  ],
  providers: [CourseRequestService, ProgressService]
)
class ReviewRequestComponent implements OnInit {
  bool isVisible;

  CourseRequest courseRequest;

  final CourseRequestService _courseRequestService;

  final ProgressService _progressService;

  /// The [ReviewRequestComponent] constructor...
  ReviewRequestComponent (this._courseRequestService, this._progressService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    isVisible = false;

    _courseRequestService.requestController.stream.listen (
      (CourseRequest theCourseRequest) {
        courseRequest = theCourseRequest;
        isVisible = true;
      }
    );

    _courseRequestService.reviewCourseRequest();
  }

  /// The [submitCourseRequest] method...
  Future<void> submitCourseRequest() async {
    _progressService.invoke ('Submitting the course request.');

    try {
      await _courseRequestService.submitCourseRequest();
    } catch (_) {}

    _progressService.revoke();
  }
}
