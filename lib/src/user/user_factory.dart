library plato.angular.factory.user;

import '../_application/factory/plato_factory.dart';

import 'plato_user.dart';
import 'user_exception.dart';

/// The [UserFactory] class...
class UserFactory implements PlatoFactory<PlatoUser> {
  /// The [UserFactory] default constructor...
  UserFactory();

  /// The [create] method...
  PlatoUser create (
    Map<String, dynamic> rawUser,
    [String username, String password, bool isLtiSession = false]
  ) {
    if (!(rawUser.containsKey ('learn.user.username') &&
          rawUser.containsKey ('learn.user.firstName') &&
          rawUser.containsKey ('learn.user.lastName') &&
          rawUser.containsKey ('learn.user.email') &&
          rawUser.containsKey ('banner.user.cwid'))) {
      throw new UserException (
        'The provided user information was not properly formatted.'
      );
    }

    return new PlatoUser (
      username, password,
      rawUser['learn.user.firstName'], rawUser['learn.user.lastName'],
      rawUser['learn.user.email'], rawUser['banner.user.cwid'],
      isLtiSession
    );
  }

  /// The [createAll] method...
  List<PlatoUser> createAll (Iterable<Map<String, dynamic>> rawUsers) {
    throw new UserException (
      'Unable to create multiple instances of a single user.'
    );
  }
}
