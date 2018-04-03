library plato.angular.factory.user;

import '../_application/factory/plato_factory.dart';

import 'user_exception.dart';
import 'user_information.dart';

/// The [UserFactory] class...
class UserFactory implements PlatoFactory<UserInformation> {
  /// The [UserFactory] default constructor...
  UserFactory();

  /// The [create] method...
  UserInformation create (
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

    return new UserInformation (
      username, password,
      rawUser['learn.user.firstName'], rawUser['learn.user.lastName'],
      rawUser['learn.user.email'], rawUser['banner.user.cwid'],
      isLtiSession
    );
  }

  /// The [createAll] method...
  List<UserInformation> createAll (Iterable<Map<String, dynamic>> rawUsers) {
    throw new UserException (
      'Unable to create multiple instances of a single user.'
    );
  }
}
