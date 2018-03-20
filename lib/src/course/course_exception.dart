library plato.angular.exceptions.course;

import '../_application/error/plato_exception.dart';

/// The [CourseException] class...
class CourseException extends PlatoException {
  /// The [CourseException] constructor...
  CourseException (
    [message = 'A general course exception has occurred; no details were provided.']
  ) : super (message);
}
