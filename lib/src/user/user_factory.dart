library plato.crf.factory.user;

import '../_application/factory/plato_factory.dart';

import 'plato_user.dart';
import 'user_exception.dart';

/// The [UserFactory] class...
class UserFactory implements PlatoFactory<PlatoUser> {
  /// The [UserFactory] default constructor...
  UserFactory();

  /// The [create] method...
  @override
  PlatoUser create (
    Map<String, dynamic> rawUser, [String username, bool isLtiSession = false]
  ) {
    if (!(rawUser.containsKey ('learn.user.username') &&
          rawUser.containsKey ('learn.user.firstName') &&
          rawUser.containsKey ('learn.user.lastName') &&
          rawUser.containsKey ('learn.user.email') &&
          rawUser.containsKey ('banner.user.cwid'))) {
      throw UserException (
        'The provided user information was not properly formatted.'
      );
    }

    return PlatoUser (
      username,
      rawUser['learn.user.firstName'], rawUser['learn.user.lastName'],
      rawUser['learn.user.email'], rawUser['banner.user.cwid'],
      isLtiSession
    );
  }

  /// The [createAll] method...
  @override
  List<PlatoUser> createAll (Iterable<Map<String, dynamic>> rawUsers) {
    throw UserException (
      'Unable to create multiple instances of a single user.'
    );
  }
}
