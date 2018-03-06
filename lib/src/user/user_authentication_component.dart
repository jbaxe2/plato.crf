library plato.angular.components.user.authentication;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../crf/course_request_service.dart';

import 'user_exception.dart';
import 'user_information_service.dart';

/// The [UserAuthenticationComponent] class...
@Component (
  selector: 'user-authentication',
  templateUrl: 'user_authentication_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [UserInformationService, CourseRequestService]
)
class UserAuthenticationComponent implements OnInit {
  String username;

  String password;

  bool get isAuthenticated => userInfoService.isAuthenticated;

  final UserInformationService userInfoService;

  final CourseRequestService crfService;

  /// The [UserAuthenticationComponent] constructor...
  UserAuthenticationComponent (this.userInfoService, this.crfService);

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
    if (isAuthenticated) {
      throw new UserException (
        'Authentication has already completed; cannot authenticate again.'
      );
    }

    try {
      await userInfoService.authenticateLearn (username, password);
      await userInfoService.retrieveUser();

      crfService.createRequestInformation (userInfoService.userInformation);
    } catch (_) {}
  }
}
