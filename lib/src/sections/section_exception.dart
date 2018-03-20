library plato.angular.exceptions.section;

import '../_application/error/plato_exception.dart';

/// The [SectionException] class...
class SectionException extends PlatoException {
  /// The [SectionException] constructor...
  SectionException (
    [message = 'A general section exception has occurred; no details were provided.']
  ) : super (message);
}
