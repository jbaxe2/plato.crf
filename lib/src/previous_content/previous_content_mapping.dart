library plato.angular.models.previous_content;

import '../enrollments/enrollment.dart';

import '../sections/section.dart';

/// The [PreviousContentMapping] class...
class PreviousContentMapping {
  final Section section;

  Enrollment enrollment;

  /// The [PreviousContentMapping] constructor...
  PreviousContentMapping (this.section, this.enrollment);
}
