library plato.angular.models.learn.previous_content;

import '../banner/section.dart';

import 'enrollment.dart';

/// The [PreviousContentMapping] class...
class PreviousContentMapping {
  final Section section;

  Enrollment enrollment;

  /// The [PreviousContentMapping] constructor...
  PreviousContentMapping (this.section, this.enrollment);
}
