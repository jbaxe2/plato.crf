library plato.angular.exceptions.crf;

import '../_application/error/plato_exception.dart';

/// The [CrfException] class...
class CrfException extends PlatoException {
  /// The [CrfException] constructor...
  CrfException (
    [message = 'A generalized course request exception has occurred; no details were provided.']
  ) : super (message);
}
