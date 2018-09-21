library plato.crf.components.user.authentication;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/progress/progress_service.dart';

import '../enrollments/enrollments_service.dart';

import 'plato_user_service.dart';

/// The [UserAuthenticationComponent] class...
@Component (
  selector: 'user-authentication',
  templateUrl: 'user_authentication_component.html',
  styleUrls: const ['user_authentication_component.css'],
  directives: const [
    materialInputDirectives, MaterialButtonComponent, MaterialIconComponent
  ],
  providers: const [
    PlatoUserService, EnrollmentsService, ProgressService
  ]
)
class UserAuthenticationComponent implements OnInit {
  String username;

  String password;

  bool get isAuthenticated => _platoUserService.isAuthenticated;

  final PlatoUserService _platoUserService;

  final EnrollmentsService _enrollmentsService;

  final ProgressService _progressService;

  /// The [UserAuthenticationComponent] constructor...
  UserAuthenticationComponent (
    this._platoUserService, this._enrollmentsService, this._progressService
  ) {
    username = '';
    password = '';
  }

  /// The [ngOnInit] method...
  @override
  Future<void> ngOnInit() async {
    try {
      _progressService.invoke (
        'Determining launch context and session information.'
      );

      await _platoUserService.retrieveSession();

      if (_platoUserService.isAuthenticated && _platoUserService.isLtiSession) {
        await _retrieveUserAndEnrollments();
      }
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [authenticateLearn] method...
  Future<void> authenticateLearn() async {
    if (username.isEmpty || password.isEmpty) {
      return;
    }

    try {
      _progressService.invoke ('Attempting to verify Plato credentials.');
      await _platoUserService.authenticateLearn (username, password);

      await _retrieveUserAndEnrollments();
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [_retrieveUserAndEnrollments] method...
  Future<void> _retrieveUserAndEnrollments() async {
    _progressService.invoke ('Retrieving the user information.');
    await _platoUserService.retrieveUser();

    _progressService.invoke ('Retrieving the instructor enrollments.');
    await _enrollmentsService.retrieveEnrollments();
  }
}
