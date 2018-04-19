library plato.angular.components.user.authentication;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/progress/progress_service.dart';

import '../archives/retrieve_archives_service.dart';

import '../enrollments/enrollments_service.dart';

import 'plato_user_service.dart';

/// The [UserAuthenticationComponent] class...
@Component (
  selector: 'user-authentication',
  templateUrl: 'user_authentication_component.html',
  styleUrls: const ['user_authentication_component.scss.css'],
  directives: const [coreDirectives, materialDirectives],
  providers: const [
    PlatoUserService, EnrollmentsService,
    RetrieveArchivesService, ProgressService
  ]
)
class UserAuthenticationComponent implements OnInit {
  String username;

  String password;

  bool get isAuthenticated => _platoUserService.isAuthenticated;

  final PlatoUserService _platoUserService;

  final EnrollmentsService _enrollmentsService;

  final RetrieveArchivesService _retrieveArchivesService;

  final ProgressService _progressService;

  /// The [UserAuthenticationComponent] constructor...
  UserAuthenticationComponent (
    this._platoUserService, this._enrollmentsService,
    this._retrieveArchivesService, this._progressService
  );

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    try {
      _progressService.invoke (
        'Determining launch context and session information.'
      );

      await _platoUserService.retrieveSession();

      if (_platoUserService.isAuthenticated && _platoUserService.isLtiSession) {
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
      await _platoUserService.authenticateLearn (username, password);

      await _retrieveUserEnrollmentsAndArchives();
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [_retrieveUserEnrollmentsAndArchives] method...
  Future _retrieveUserEnrollmentsAndArchives() async {
    _progressService.invoke ('Retrieving the user information.');
    await _platoUserService.retrieveUser();

    _progressService.invoke ('Retrieving the instructor enrollments.');
    await _enrollmentsService.retrieveEnrollments();

    _progressService.invoke ('Determining if there are any archived enrollments.');
    await _retrieveArchivesService.retrieveArchives();
  }
}
