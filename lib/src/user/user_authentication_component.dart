library plato.angular.components.user.authentication;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'user_information_service.dart';

/// The [UserAuthenticationComponent] class...
@Component (
  selector: 'user-authentication',
  templateUrl: 'user_authentication_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [UserInformationService]
)
class UserAuthenticationComponent implements OnInit {
  @Input()
  String username;

  @Input()
  String password;

  @Output()
  bool get isAuthenticated => userInfoService.isAuthenticated;

  final UserInformationService userInfoService;

  /// The [UserAuthenticationComponent] constructor...
  UserAuthenticationComponent (this.userInfoService);

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    try {
      await userInfoService.retrieveSession();

      if (userInfoService.isAuthenticated && userInfoService.isLtiSession) {
        await userInfoService.retrieveUser();
      }
    } catch (_) {}
  }

  /// The [authenticateLearn] method...
  Future authenticateLearn() async {
    try {
      await userInfoService.authenticateLearn (username, password);
      await userInfoService.retrieveUser();
    } catch (_) {}
  }
}
