library plato.crf.components.user;

import 'package:angular/angular.dart';

import '../_application/workflow/workflow_service.dart';

import 'plato_user_component.dart';
import 'plato_user_service.dart';
import 'user_authorization_component.dart';

/// The [UserComponent] class...
@Component(
  selector: 'user',
  templateUrl: 'user_component.html',
  directives: [
    UserAuthorizationComponent, PlatoUserComponent,
    NgIf
  ],
  providers: [PlatoUserService, WorkflowService]
)
class UserComponent implements OnInit {
  bool _isAuthorized;

  bool get isAuthorized => _isAuthorized;

  final PlatoUserService _platoUserService;

  final WorkflowService _workflowService;

  /// The [UserComponent] constructor...
  UserComponent (this._platoUserService, this._workflowService) {
    _isAuthorized = false;
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _markIfAuthorized (_isAuthorized = _platoUserService.isAuthorized);

    _platoUserService.authStreamController.stream.listen (_markIfAuthorized);
    _workflowService.sectionsResetStream.listen (_markAuthorized);
  }

  /// The [_markIfAuthorized] method...
  void _markIfAuthorized (bool authReceived) {
    if ((_isAuthorized = authReceived)) {
      _markAuthorized (authReceived);
    }
  }

  /// The [_markAuthorized] method...
  void _markAuthorized (_) => _workflowService.markUserAuthorized();
}
