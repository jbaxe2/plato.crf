library plato.angular.services.previous_content;

import 'dart:async' show StreamController;

import 'package:angular/core.dart';

import '../course_request/course_request.dart';

import '../enrollments/enrollment.dart';

import '../sections/featured_section_service.dart';
import '../sections/section.dart';

import 'previous_content_exception.dart';
import 'previous_content_mapping.dart';

/// The [PreviousContentService] class...
@Injectable()
class PreviousContentService extends FeaturedSectionService {
  List<PreviousContentMapping> previousContents;

  StreamController<PreviousContentMapping> previousContentStreamer;

  CourseRequest _courseRequest;

  static PreviousContentService _instance;

  /// The [PreviousContentService] factory constructor...
  factory PreviousContentService() =>
    _instance ?? (_instance = new PreviousContentService._());

  /// The [PreviousContentService] private constructor...
  PreviousContentService._() {
    _courseRequest = new CourseRequest();

    previousContents = _courseRequest.previousContents;
    previousContentStreamer = new StreamController<PreviousContentMapping>.broadcast();

    init();
  }

  /// The [revokeSection] method...
  void revokeSection() {}

  /// The [createPreviousContent] method...
  PreviousContentMapping createPreviousContent (Section section, Enrollment enrollment) {
    var previousContent = new PreviousContentMapping (section, enrollment);

    addPreviousContent (previousContent);

    return previousContent;
  }

  /// The [addPreviousContent] method...
  void addPreviousContent (PreviousContentMapping previousContent) {
    try {
      _courseRequest.addPreviousContentMapping (previousContent);
    } catch (_) {
      rethrow;
    }
  }

  /// The [removePreviousContent] method...
  void removePreviousContent (PreviousContentMapping previousContent) {
    _courseRequest.removePreviousContent (previousContent);
  }

  /// The [setPreviousContentEnrollment] method...
  void setPreviousContentEnrollment (
    PreviousContentMapping previousContent, Enrollment enrollment
  ) {
    _courseRequest.setPreviousContentEnrollment (previousContent, enrollment);
  }

  /// The [confirmPreviousContents] method...
  void confirmPreviousContents() {
    if (previousContents.any (
      (PreviousContentMapping previousContent) => (null == previousContent.enrollment)
    )) {
      throw new PreviousContentException (
        'Cannot confirm previous contents when no enrollment has been selected.'
      );
    }

    if (previousContents.isEmpty) {
      previousContentStreamer.add (null);

      return;
    }

    previousContents.forEach (
      (PreviousContentMapping previousContent) =>
        previousContentStreamer.add (previousContent)
    );
  }
}
