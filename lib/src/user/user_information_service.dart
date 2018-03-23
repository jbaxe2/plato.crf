library plato.angular.services.user.information;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import '../user/user_exception.dart';

import 'user_information.dart';

const String _LEARN_AUTH_URI = '/plato/authenticate/learn';
const String _SESSION_URI = '/plato/retrieve/session';
const String _USER_URI = '/plato/retrieve/user';

@Injectable()
/// The [UserInformationService] class...
class UserInformationService {
  UserInformation userInformation;

  String _username;

  String _password;

  bool _isLtiSession;

  bool get isLtiSession => _isLtiSession;

  bool _isAuthenticated;

  bool get isAuthenticated => _isAuthenticated;

  StreamController<bool> authStreamController;

  final Client _http;

  static UserInformationService _instance;

  /// The [UserInformationService] factory constructor...
  factory UserInformationService (Client http) =>
    _instance ?? (_instance = new UserInformationService._ (http));

  /// The [UserInformationService] private constructor...
  UserInformationService._ (this._http) {
    _isLtiSession = false;
    _isAuthenticated = false;

    authStreamController = new StreamController<bool>.broadcast();
  }

  /// The [retrieveSession] method...
  Future retrieveSession() async {
    try {
      final Response sessionResponse = await _http.get (_SESSION_URI);

      Map<String, dynamic> rawSession =
        (JSON.decode (sessionResponse.body) as Map)['session'];

      if ((rawSession.containsKey ('plato.session.exists')) &&
          (rawSession.containsKey ('learn.user.authenticated'))) {
        if ('true' == rawSession['learn.user.authenticated']) {
          _isLtiSession = true;
          _isAuthenticated = true;
        }
      }
    } catch (_) {
      throw new UserException ('Unable to determine if a user session exists.');
    }
  }

  /// The [authenticateLearn] method...
  Future authenticateLearn (String theUsername, String thePassword) async {
    if (isAuthenticated) {
      throw new UserException (
        'Authentication has already completed; cannot authenticate again.'
      );
    }

    if (theUsername.isEmpty || thePassword.isEmpty) {
      return;
    }

    try {
      final Response authResponse = await _http.post (
        _LEARN_AUTH_URI,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': theUsername, 'password': thePassword}
      );

      Map<String, dynamic> rawAuth = JSON.decode (authResponse.body) as Map;

      if (true == rawAuth['learn.user.authenticated']) {
        _isAuthenticated = true;

        _username = theUsername;
        _password = thePassword;
      } else {
        throw theUsername;
      }
    } catch (_) {
      throw new UserException ('Authentication for the Plato user has failed.');
    }
  }

  /// The [retrieveUser] method...
  Future retrieveUser() async {
    if (!_isAuthenticated) {
      throw new UserException (
        'Authentication must happen before retrieving user information.'
      );
    }

    try {
      final Response userResponse = await _http.get (_USER_URI);

      Map<String, String> rawUser =
        (JSON.decode (userResponse.body) as Map)['user'];

      _username = rawUser['learn.user.username'];

      userInformation = new UserInformation (
        _username, _password, rawUser['learn.user.firstName'],
        rawUser['learn.user.lastName'], rawUser['learn.user.email'],
        rawUser['banner.user.cwid'], _isLtiSession
      );
    } catch (_) {
      throw new UserException ('Unable to retrieve the user information.');
    }

    authStreamController.add (true);
  }
}
