library plato.angular.models.learn.previous_content;

import 'package:plato_angular/src/sections/section.dart';

import 'package:plato_angular/src/enrollments/enrollment.dart';

/// The [PreviousContentMapping] class...
class PreviousContentMapping {
  final Section section;

  Enrollment enrollment;

  /// The [PreviousContentMapping] constructor...
  PreviousContentMapping (this.section, this.enrollment);
}
