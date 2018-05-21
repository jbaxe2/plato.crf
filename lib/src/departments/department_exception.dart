library plato.crf.exceptions.department;

import '../_application/error/plato_exception.dart';

/// The [DepartmentException] class...
class DepartmentException extends PlatoException {
  /// The [DepartmentException] constructor...
  DepartmentException (
    [message = 'A general department exception has occurred; no details were provided.']
  ) : super (message);
}
