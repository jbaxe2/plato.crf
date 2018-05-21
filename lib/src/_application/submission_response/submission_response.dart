library plato.crf.models.submission_response;

import '../../courses/rejected_course.dart';

/// The [SubmissionResponse] class...
class SubmissionResponse {
  final bool success;

  final List<RejectedCourse> rejectedCourses;

  /// The [SubmissionResponse] constructor...
  SubmissionResponse (this.success, this.rejectedCourses);
}
