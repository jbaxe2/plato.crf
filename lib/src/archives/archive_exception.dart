library plato.angular.exceptions.archive;

import '../_application/error/plato_exception.dart';

/// The [ArchiveException] class...
class ArchiveException extends PlatoException {
  /// The [ArchiveException] constructor...
  ArchiveException (
    [message = 'A general archive exception has occurred; no details were provided.']
  ) : super (message);
}
