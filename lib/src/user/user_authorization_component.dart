library plato.crf.components.user.authorization;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/progress/progress_service.dart';

import '../enrollments/enrollments_service.dart';

import 'plato_user_service.dart';

/// The [UserAuthorizationComponent] class...
@Component (
  selector: 'user-authorization',
  templateUrl: 'user_authorization_component.html',
  styleUrls: const ['user_authorization_component.css'],
  directives: const [
    materialInputDirectives, MaterialButtonComponent, MaterialIconComponent
  ],
  providers: const [
    PlatoUserService, EnrollmentsService, ProgressService
  ]
)
class UserAuthorizationComponent implements OnInit {
  bool get isAuthorized => _platoUserService.isAuthorized;

  final PlatoUserService _platoUserService;

  final EnrollmentsService _enrollmentsService;

  final ProgressService _progressService;

  /// The [UserAuthorizationComponent] constructor...
  UserAuthorizationComponent (
    this._platoUserService, this._enrollmentsService, this._progressService
  );

  /// The [ngOnInit] method...
  @override
  Future<void> ngOnInit() async {
    try {
      _progressService.invoke (
        'Determining launch context and session information.'
      );

      await _platoUserService.retrieveSession();

      if ((_platoUserService.isAuthorized && _platoUserService.isLtiSession) ||
          await _platoUserService.authorizeUser()) {
        await _retrieveUserAndEnrollments();
      }
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [authorize] method...
  Future<void> authorize() async {
    try {
      _progressService.invoke ('Attempting to authorize Plato credentials.');

      await _platoUserService.authorizeApplication();
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
