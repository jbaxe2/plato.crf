library plato.angular.exceptions.learn;

import 'plato_exception.dart';

/// The [LearnException] class...
class LearnException extends PlatoException {
  /// The [LearnException] constructor...
  LearnException (
    [message = 'A general Learn exception has occurred; no details were provided.']
  ) : super (message);
}
