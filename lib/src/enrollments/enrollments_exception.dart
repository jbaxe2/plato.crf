library plato.angular.exceptions.enrollments;

import '../_application/error/plato_exception.dart';

/// The [EnrollmentsException] class...
class EnrollmentsException extends PlatoException {
  /// The [EnrollmentsException] constructor...
  EnrollmentsException (
    [message = 'A general enrollments exception has occurred; no details were provided.']
  ) : super (message);
}
