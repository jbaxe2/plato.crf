library plato.crf.services.user.plato;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show json, utf8;
import 'dart:html' show window;

import 'package:http/http.dart' show Client, Response;

import '../course_request/course_request.dart';

import 'plato_user.dart';
import 'user_exception.dart';
import 'user_factory.dart';

const String _LEARN_AUTH_URI = '/plato/authenticate/learn';
const String _SESSION_URI = '/plato/retrieve/session';
const String _USER_URI = '/plato/retrieve/user';

final String _REST_AUTH_URI =
  'https://bbl.westfield.ma.edu/learn/api/public/v1/oauth2/authorizationcode'
  '?redirect_uri=${Uri.encodeFull (window.location.href)}'
  '&client_id=f36e3a35-e275-4090-b2e4-f7590038dec2'
  '&response_type=code&scope=read';

/// The [PlatoUserService] class...
class PlatoUserService {
  PlatoUser platoUser;

  CourseRequest _courseRequest;

  String _username;

  bool _isLtiSession;

  bool get isLtiSession => _isLtiSession;

  bool _isAuthorized;

  bool get isAuthorized => _isAuthorized;

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
    _isAuthorized = false;

    authStreamController = new StreamController<bool>.broadcast();
    _userFactory = new UserFactory();
    _courseRequest = new CourseRequest();
  }

  /// The [retrieveSession] method...
  Future<void> retrieveSession() async {
    try {
      final Response sessionResponse = await _http.get (_SESSION_URI);

      final Map<String, dynamic> rawSession =
        (json.decode (utf8.decode (sessionResponse.bodyBytes)) as Map)['session'];

      if ((rawSession.containsKey ('plato.session.exists')) &&
          (rawSession.containsKey ('learn.user.authenticated'))) {
        if ('true' == rawSession['learn.user.authenticated']) {
          _isAuthorized = true;

          if ((rawSession.containsKey ('plato.lti.session')) &&
              ('true' == rawSession['plato.lti.session'])) {
            _isLtiSession = true;
          }
        }
      }
    } catch (_) {
      throw new UserException ('Unable to determine if a user session exists.');
    }
  }

  /// The [authorizeApplication] method...
  Future<void> authorizeApplication() async {
    if (isAuthorized) {
      throw new UserException ('Authorization has already completed.');
    }

    try {
      window.location.replace (_REST_AUTH_URI);
    } catch (_) {
      throw new UserException ('Authorization for the Plato user has failed.');
    }
  }

  /// The [authorizeUser] method...
  Future<bool> authorizeUser() async {
    var location = Uri.parse (window.location.href);

    if (location.queryParameters.containsKey ('code')) {
      try {
        final Response rawAuthResponse = await _http.post (
          Uri.parse (_LEARN_AUTH_URI),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'authCode': location.queryParameters['code']}
        );

        final Map<String, dynamic> authResponse =
          json.decode (utf8.decode (rawAuthResponse.bodyBytes)) as Map;

        if (true == authResponse['learn.user.authenticated']) {
          _isAuthorized = true;
        } else {
          throw authResponse;
        }
      } catch (_) {
        throw new UserException (
          'Establishing user context via authorization has failed.'
        );
      }

      return true;
    }

    return false;
  }

  /// The [retrieveUser] method...
  Future<void> retrieveUser() async {
    if (!_isAuthorized) {
      throw new UserException (
        'Authorization must happen before retrieving user information.'
      );
    }

    try {
      final Response userResponse = await _http.get (_USER_URI);

      final Map<String, String> rawUser =
        (json.decode (utf8.decode (userResponse.bodyBytes)) as Map)['user'];

      _username = rawUser['learn.user.username'];

      platoUser = _userFactory.create (rawUser, _username, _isLtiSession);
    } catch (_) {
      throw new UserException ('Unable to retrieve the user information.');
    }

    _courseRequest.setPlatoUser (platoUser);
    authStreamController.add (true);
  }
}
