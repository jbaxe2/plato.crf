library plato.crf.services.user.plato;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show json, utf8;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import '../course_request/course_request.dart';

import 'plato_user.dart';
import 'user_exception.dart';
import 'user_factory.dart';

const String _LEARN_AUTH_URI = '/plato/authenticate/learn';
const String _SESSION_URI = '/plato/retrieve/session';
const String _USER_URI = '/plato/retrieve/user';

@Injectable()
/// The [PlatoUserService] class...
class PlatoUserService {
  PlatoUser platoUser;

  CourseRequest _courseRequest;

  String _username;

  String _password;

  bool _isLtiSession;

  bool get isLtiSession => _isLtiSession;

  bool _isAuthenticated;

  bool get isAuthenticated => _isAuthenticated;

  StreamController<bool> authStreamController;

  UserFactory _userFactory;

  final Client _http;

  static PlatoUserService _instance;

  /// The [PlatoUserService] factory constructor...
  factory PlatoUserService (Client http) =>
    _instance ?? (_instance = new PlatoUserService._ (http));

  /// The [PlatoUserService] private constructor...
  PlatoUserService._ (this._http) {
    _isLtiSession = false;
    _isAuthenticated = false;

    authStreamController = new StreamController<bool>.broadcast();
    _userFactory = new UserFactory();
    _courseRequest = new CourseRequest();
  }

  /// The [retrieveSession] method...
  Future retrieveSession() async {
    try {
      final Response sessionResponse = await _http.get (_SESSION_URI);

      final Map<String, dynamic> rawSession =
        (json.decode (utf8.decode (sessionResponse.bodyBytes)) as Map)['session'];

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

      final Map<String, dynamic> rawAuth =
        json.decode (utf8.decode (authResponse.bodyBytes)) as Map;

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

      final Map<String, String> rawUser =
        (json.decode (utf8.decode (userResponse.bodyBytes)) as Map)['user'];

      _username = rawUser['learn.user.username'];

      platoUser = _userFactory.create (
        rawUser, _username, _password, _isLtiSession
      );
    } catch (_) {
      throw new UserException ('Unable to retrieve the user information.');
    }

    _courseRequest.setPlatoUser (platoUser);
    authStreamController.add (true);
  }
}
