library plato.angular.components.user;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'user_authentication_component.dart';
import 'user_information_component.dart';
import 'user_information_service.dart';

/// The [UserComponent] class...
@Component(
  selector: 'user',
  templateUrl: 'user_component.html',
  directives: const [
    CORE_DIRECTIVES, materialDirectives,
    UserAuthenticationComponent, UserInformationComponent
  ],
  providers: const [UserInformationService]
)
class UserComponent implements OnInit {
  bool _isAuthenticated;

  bool get isAuthenticated => _isAuthenticated;

  final UserInformationService _userInfoService;

  /// The [UserComponent] constructor...
  UserComponent (this._userInfoService) {
    _isAuthenticated = false;
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _isAuthenticated = _userInfoService.isAuthenticated;

    _userInfoService.authStreamController.stream.listen (
      (bool authReceived) => (_isAuthenticated = authReceived)
    );
  }
}
