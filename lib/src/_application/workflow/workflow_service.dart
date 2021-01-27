library plato.crf.services.workflow;

import 'dart:async' show Stream, StreamController;

/// The [WorkflowService] class...
class WorkflowService {
  static final StreamController<bool> _workflowController =
    StreamController<bool>.broadcast();

  Stream<bool> get workflowStream => _workflowController.stream;

  static final StreamController<bool> _sectionsResetController =
    StreamController<bool>.broadcast();

  Stream<bool> get sectionsResetStream => _sectionsResetController.stream;

  /// The [WorkflowService] constructor...
  WorkflowService();

  /// The [markPreventWorkflowProgress] method...
  void markPreventWorkflowProgress() => _workflowController.add (false);

  /// The [markUserAuthorized] method...
  void markUserAuthorized() => _workflowController.add (true);

  /// The [markCoursesSelected] method...
  void markCoursesSelected() => _workflowController.add (true);

  /// The [markCrossListingsHandled] method...
  void markCrossListingsHandled() => _workflowController.add (true);

  /// The [markPreviousContentHandled] method...
  void markPreviousContentHandled() => _workflowController.add (true);

  /// The [markSectionsReset] method...
  void markSectionsReset() {
    _workflowController.add (false);
    _sectionsResetController.add (true);
  }
}
