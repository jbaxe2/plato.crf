library plato.crf.components.workflow;

import 'dart:async' show Future;
import 'dart:html' show Event, window;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../cross_listings/cross_listings_component.dart';
import '../../previous_content/previous_content_component.dart';
import '../../sections/requesting/requesting_sections_component.dart';
import '../../user/user_component.dart';

import '../review_request/review_request_component.dart';

import 'workflow_service.dart';

/// The [WorkflowComponent] class...
@Component(
  selector: 'workflow',
  templateUrl: 'workflow_component.html',
  styleUrls: ['workflow_component.css'],
  directives: [
    MaterialButtonComponent, MaterialIconComponent, MaterialStepperComponent,
    StepDirective,
    CrossListingsComponent, PreviousContentComponent,
    RequestingSectionsComponent, ReviewRequestComponent, UserComponent,
    NgIf
  ],
  providers: [WorkflowService]
)
class WorkflowComponent implements AfterViewInit {
  bool _canStep;

  bool get canStep => _canStep;

  @ViewChild("workflowStepper")
  MaterialStepperComponent stepper;

  final WorkflowService _workflowService;

  /// The [WorkflowComponent] constructor...
  WorkflowComponent (this._workflowService) {
    _canStep = false;
  }

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    _workflowService
      ..workflowStream.listen ((bool stepMarked) => _canStep = stepMarked)
      ..sectionsResetStream.listen ((_) async => await resetToSectionSelection());
  }

  /// The [progressInWorkflow] method...
  void progressInWorkflow (Event event) {
    stepper.stepForward (event, stepper.steps[stepper.activeStepIndex + 1]);
    _workflowService.markWorkflowProgressed();
  }

  /// The [goBackInWorkflow] method...
  void goBackInWorkflow (Event event) {
    if (stepper.activeStep.isFirst) {
      return;
    }

    stepper.stepBackward (event, stepper.steps[stepper.activeStepIndex - 1]);
    _canStep = true;
  }

  /// The [resetToSectionSelection] method...
  Future<bool> resetToSectionSelection() async {
    bool jumped = await stepper.jumpStep (1);

    _workflowService.markWorkflowProgressed();

    return jumped;
  }
}
