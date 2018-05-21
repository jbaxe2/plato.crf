library plato.crf.exceptions.course_request;

import '../_application/error/plato_exception.dart';

/// The [CourseRequestException] class...
class CourseRequestException extends PlatoException {
  /// The [CourseRequestException] constructor...
  CourseRequestException (
    [message = 'A generalized course request exception has occurred; no details were provided.']
  ) : super (message);
}
