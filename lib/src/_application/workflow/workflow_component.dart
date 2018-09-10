library plato.crf.components.workflow;

import 'dart:html' show Event;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../sections/requesting/requesting_sections_component.dart';
import '../../user/user_component.dart';

import 'workflow_service.dart';

/// The [WorkflowComponent] class...
@Component(
  selector: 'workflow',
  templateUrl: 'workflow_component.html',
  styleUrls: ['workflow_component.css'],
  directives: [
    MaterialButtonComponent, MaterialStepperComponent, StepDirective,
    RequestingSectionsComponent, UserComponent,
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
    _workflowService.workflowStream.listen (
      (bool stepMarked) => _canStep = stepMarked
    );
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
}
