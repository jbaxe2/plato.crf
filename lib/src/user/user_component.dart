library plato.crf.components.user;

import 'package:angular/angular.dart';

import '../_application/workflow/workflow_service.dart';

import 'plato_user_component.dart';
import 'plato_user_service.dart';
import 'user_authentication_component.dart';

/// The [UserComponent] class...
@Component(
  selector: 'user',
  templateUrl: 'user_component.html',
  directives: const [
    UserAuthenticationComponent, PlatoUserComponent,
    NgIf
  ],
  providers: const [PlatoUserService, WorkflowService]
)
class UserComponent implements OnInit {
  bool _isAuthenticated;

  bool get isAuthenticated => _isAuthenticated;

  final PlatoUserService _platoUserService;

  final WorkflowService _workflowService;

  /// The [UserComponent] constructor...
  UserComponent (this._platoUserService, this._workflowService) {
    _isAuthenticated = false;
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _markIfAuthenticated (_isAuthenticated = _platoUserService.isAuthenticated);

    _platoUserService.authStreamController.stream.listen (_markIfAuthenticated);
    _workflowService.sectionsResetStream.listen (_markAuthenticated);
  }

  /// The [_markIfAuthenticated] method...
  void _markIfAuthenticated (bool authReceived) {
    if ((_isAuthenticated = authReceived)) {
      _markAuthenticated (authReceived);
    }
  }

  /// The [_markAuthenticated] method...
  void _markAuthenticated (_) => _workflowService.markUserAuthenticated();
}
