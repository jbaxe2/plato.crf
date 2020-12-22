library plato.crf.models.user.plato;

/// The [PlatoUser] class...
class PlatoUser {
  final String username;

  final String firstName;

  final String lastName;

  final String email;

  final String cwid;

  final bool _isLtiSession;

  bool get isLtiSession => _isLtiSession;

  static PlatoUser _instance;

  /// The [PlatoUser] factory constructor...
  factory PlatoUser (
    String username, String firstName, String lastName,
    String email, String cwid, [bool isLtiSession = false]
  ) {
    return _instance ?? (_instance = PlatoUser._ (
      username, firstName, lastName, email, cwid, isLtiSession
    ));
  }

  /// The [PlatoUser] private constructor...
  PlatoUser._ (
    this.username, this.firstName, this.lastName, this.email,
    this.cwid, [this._isLtiSession = false]
  );

  /// The [toJson] method...
  Object toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'cwid': cwid
    };
  }
}
