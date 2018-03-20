library plato.angular.components.user.authentication;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../archive/archives_service.dart';

import '../course_request/course_request_service.dart';

import '../enrollments/enrollments_service.dart';

import 'user_information_service.dart';

/// The [UserAuthenticationComponent] class...
@Component (
  selector: 'user-authentication',
  templateUrl: 'user_authentication_component.html',
  styleUrls: const ['user_authentication_component.scss.css'],
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [
    UserInformationService, CourseRequestService, EnrollmentsService, ArchivesService
  ]
)
class UserAuthenticationComponent implements OnInit {
  String username;

  String password;

  bool get isAuthenticated => _userInfoService.isAuthenticated;

  final UserInformationService _userInfoService;

  final CourseRequestService _crfService;

  final EnrollmentsService _enrollmentsService;

  final ArchivesService _archivesService;

  /// The [UserAuthenticationComponent] constructor...
  UserAuthenticationComponent (
    this._userInfoService, this._crfService,
    this._enrollmentsService, this._archivesService
  );

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    try {
      await _userInfoService.retrieveSession();

      if (_userInfoService.isAuthenticated && _userInfoService.isLtiSession) {
        await _userInfoService.retrieveUser();

        _retrieveEnrollmentsAndArchives();
      }
    } catch (_) {}
  }

  /// The [authenticateLearn] method...
  Future authenticateLearn() async {
    try {
      await _userInfoService.authenticateLearn (username, password);
      await _userInfoService.retrieveUser();

      _crfService.setUserInformation (_userInfoService.userInformation);

      _retrieveEnrollmentsAndArchives();
    } catch (_) {}
  }

  /// The [_retrieveEnrollmentsAndArchives] method...
  Future _retrieveEnrollmentsAndArchives() async {
    _enrollmentsService.retrieveEnrollments();
    _archivesService.retrieveArchives();
  }
}
