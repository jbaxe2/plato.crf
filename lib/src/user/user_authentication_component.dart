library plato.angular.components.user.authentication;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/progress/progress_service.dart';

import '../archives/archives_service.dart';

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
    UserInformationService, CourseRequestService, EnrollmentsService,
    ArchivesService, ProgressService
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

  final ProgressService _progressService;

  /// The [UserAuthenticationComponent] constructor...
  UserAuthenticationComponent (
    this._userInfoService, this._crfService, this._enrollmentsService,
    this._archivesService, this._progressService
  );

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    try {
      _progressService.invoke (
        'Determining launch context and session information.'
      );

      await _userInfoService.retrieveSession();

      if (_userInfoService.isAuthenticated && _userInfoService.isLtiSession) {
        await _retrieveUserEnrollmentsAndArchives();
      }
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [authenticateLearn] method...
  Future authenticateLearn() async {
    if (username.isEmpty || password.isEmpty) {
      return;
    }

    try {
      _progressService.invoke ('Attempting to verify Plato credentials.');
      await _userInfoService.authenticateLearn (username, password);

      await _retrieveUserEnrollmentsAndArchives();
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [_retrieveUserEnrollmentsAndArchives] method...
  Future _retrieveUserEnrollmentsAndArchives() async {
    _progressService.invoke ('Retrieving the user information.');
    await _userInfoService.retrieveUser();
    _crfService.setUserInformation (_userInfoService.userInformation);

    _progressService.invoke ('Retrieving the instructor enrollments.');
    await _enrollmentsService.retrieveEnrollments();

    _progressService.invoke ('Determining if there are any archived enrollments.');
    await _archivesService.retrieveArchives();
  }
}
