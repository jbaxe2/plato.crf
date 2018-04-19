library plato.angular.components.user;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'plato_user_component.dart';
import 'plato_user_service.dart';
import 'user_authentication_component.dart';

/// The [UserComponent] class...
@Component(
  selector: 'user',
  templateUrl: 'user_component.html',
  directives: const [
    coreDirectives, materialDirectives,
    UserAuthenticationComponent, PlatoUserComponent
  ],
  providers: const [PlatoUserService]
)
class UserComponent implements OnInit {
  bool _isAuthenticated;

  bool get isAuthenticated => _isAuthenticated;

  final PlatoUserService _platoUserService;

  /// The [UserComponent] constructor...
  UserComponent (this._platoUserService) {
    _isAuthenticated = false;
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _isAuthenticated = _platoUserService.isAuthenticated;

    _platoUserService.authStreamController.stream.listen (
      (bool authReceived) => (_isAuthenticated = authReceived)
    );
  }
}
