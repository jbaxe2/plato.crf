library plato.angular.exceptions.user;

import '../crf/plato_exception.dart';

/// The [UserException] class...
class UserException extends PlatoException {
  /// The [UserException] constructor...
  UserException (
    [message = 'A generalized user exception has occurred; no details were provided.']
  ) : super (message);
}
