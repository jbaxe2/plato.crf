library plato.crf.services.workflow;

import 'dart:async' show Stream, StreamController;

/// The [WorkflowService] class...
class WorkflowService {
  static StreamController<bool> _workflowController =
    new StreamController<bool>.broadcast();

  Stream<bool> get workflowStream => _workflowController.stream;

  static StreamController<bool> _sectionsResetController =
    new StreamController<bool>.broadcast();

  Stream<bool> get sectionsResetStream => _sectionsResetController.stream;

  /// The [WorkflowService] constructor...
  WorkflowService();

  /// The [markWorkflowProgressed] method...
  void markWorkflowProgressed() => _workflowController.add (false);

  /// The [markUserAuthenticated] method...
  void markUserAuthenticated() => _workflowController.add (true);

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
