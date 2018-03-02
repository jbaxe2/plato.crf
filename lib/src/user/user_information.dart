library plato.angular.models.user.information;

/// The [UserInformation] class...
class UserInformation {
  final String username;

  final String password;

  final String firstName;

  final String lastName;

  final String email;

  final String cwid;

  final bool _isLtiSession;

  bool get isLtiSession => _isLtiSession;

  /// The [UserInformation] constructor...
  UserInformation (
    this.username, this.password, this.firstName, this.lastName, this.email, this.cwid,
    [this._isLtiSession = false]
  );
}
