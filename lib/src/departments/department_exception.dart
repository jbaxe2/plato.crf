library plato.angular.exceptions.department;

import '../crf/plato_exception.dart';

/// The [DepartmentException] class...
class DepartmentException extends PlatoException {
  /// The [DepartmentException] constructor...
  DepartmentException (
    [message = 'A general department exception has occurred; no details were provided.']
  ) : super (message);
}
