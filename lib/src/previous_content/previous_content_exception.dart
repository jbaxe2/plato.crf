library plato.angular.exceptions.previous_content;

import '../crf/plato_exception.dart';

/// The [PreviousContentException] class...
class PreviousContentException extends PlatoException {
  /// The [PreviousContentException] constructor...
  PreviousContentException (
    [message = 'A general previous content exception has occurred; no details were provided.']
  ) : super (message);
}
