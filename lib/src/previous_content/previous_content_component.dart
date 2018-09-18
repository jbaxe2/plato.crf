library plato.crf.components.previous_content;

import 'package:angular/angular.dart';

import '../_application/workflow/workflow_service.dart';

import '../course_request/course_request_service.dart';

import 'previous_content_service.dart';

/// The [PreviousContentComponent] class...
@Component(
  selector: 'previous-content',
  templateUrl: 'previous_content_component.html',
  directives: const [],
  providers: const [
    CourseRequestService, PreviousContentService, WorkflowService
  ]
)
class PreviousContentComponent implements OnInit {
  final CourseRequestService _courseRequestService;

  final PreviousContentService _previousContentService;

  final WorkflowService _workflowService;

  /// The [PreviousContentComponent] constructor...
  PreviousContentComponent (
    this._courseRequestService, this._previousContentService, this._workflowService
  );

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => _workflowService.markPreviousContentHandled();
}
