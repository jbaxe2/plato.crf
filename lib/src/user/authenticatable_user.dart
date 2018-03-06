library plato.angular.models.user.authenticatable;

/// The [AuthenticatableUser] class...
class AuthenticatableUser {
  final String username;

  final String password;

  final bool isLtiAuthenticated;

  static AuthenticatableUser _instance;

  /// The [AuthenticatableUser] factory constructor...
  factory AuthenticatableUser (
    String username, String password, [bool isLtiAuthenticated = false]
  ) {
    return _instance ??
      (_instance = new AuthenticatableUser._ (username, password, isLtiAuthenticated));
  }

  /// The [AuthenticatableUser] private constructor...
  AuthenticatableUser._ (this.username, this.password, this.isLtiAuthenticated);
}
