library plato.angular.exceptions.term;

import '../crf/plato_exception.dart';

/// The [TermException] class...
class TermException extends PlatoException {
  /// The [TermException] constructor...
  TermException (
    [message = 'A general term exception has occurred; no details were provided.']
  ) : super (message);
}
