library plato.crf.services.workflow;

import 'dart:async' show Stream, StreamController;

import 'package:angular/angular.dart' show Injectable;

/// The [WorkflowService] class...
@Injectable()
class WorkflowService {
  static StreamController<bool> _workflowController =
    new StreamController<bool>.broadcast();

  Stream<bool> get workflowStream => _workflowController.stream;

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
}
