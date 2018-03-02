library plato.angular.models.user.authenticatable;

/// The [AuthenticatableUser] class...
class AuthenticatableUser {
  final String username;

  final String password;

  final bool isLtiAuthenticated;

  /// The [AuthenticatableUser] constructor...
  AuthenticatableUser (
    this.username, this.password,
    [this.isLtiAuthenticated = false]
  );
}
