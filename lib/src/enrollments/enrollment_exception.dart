library plato.angular.exceptions.enrollments;

import '../_application/error/plato_exception.dart';

/// The [EnrollmentException] class...
class EnrollmentException extends PlatoException {
  /// The [EnrollmentException] constructor...
  EnrollmentException (
    [message = 'A general enrollment exception has occurred; no details were provided.']
  ) : super (message);
}
