library plato.angular.exceptions.section.requested;

import '../../_application/error/plato_exception.dart';

/// The [RequestedSectionException] class...
class RequestedSectionException extends PlatoException {
  /// The [RequestedSectionException] constructor...
  RequestedSectionException (
    [message = 'A general requested section exception has occurred; no details were provided.']
  ) : super (message);
}
