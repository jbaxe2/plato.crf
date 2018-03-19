library plato.angular.services.learn.previous_content;

import 'dart:async' show StreamController;

import 'package:angular/core.dart';

import '../banner/section.dart';

import '../crf/extra_info_service.dart';
import '../crf/request_information.dart';

import '../learn/enrollment.dart';

import 'previous_content_exception.dart';
import 'previous_content_mapping.dart';

/// The [PreviousContentService] class...
@Injectable()
class PreviousContentService extends ExtraInfoService {
  List<PreviousContentMapping> previousContents;

  StreamController<PreviousContentMapping> previousContentStreamer;

  RequestInformation _requestInformation;

  static PreviousContentService _instance;

  /// The [PreviousContentService] factory constructor...
  factory PreviousContentService() =>
    _instance ?? (_instance = new PreviousContentService._());

  /// The [PreviousContentService] private constructor...
  PreviousContentService._() {
    _requestInformation = new RequestInformation();

    previousContents = _requestInformation.previousContents;
    previousContentStreamer = new StreamController<PreviousContentMapping>.broadcast();

    init();
  }

  /// The [createPreviousContent] method...
  PreviousContentMapping createPreviousContent (Section section, Enrollment enrollment) {
    var previousContent = new PreviousContentMapping (section, enrollment);

    try {
      _requestInformation.addPreviousContentMapping (previousContent);
    } catch (_) { rethrow; }

    return previousContent;
  }

  /// The [revokeSection] method...
  void revokeSection() {}

  /// The [addPreviousContent] method...
  void addPreviousContent (PreviousContentMapping previousContent) {
    _requestInformation.addPreviousContentMapping (previousContent);
  }

  /// The [removePreviousContent] method...
  void removePreviousContent (PreviousContentMapping previousContent) =>
    _requestInformation.removePreviousContent (previousContent);

  /// The [addPreviousContentForSection] method...
  void addPreviousContentForSection (
    PreviousContentMapping previousContent, Section section
  ) {
    _requestInformation.addPreviousContentForSection (previousContent, section);
  }

  /// The [confirmPreviousContents] method...
  void confirmPreviousContents() {
    if (
      previousContents.any (
        (PreviousContentMapping previousContent) => (null == previousContent.enrollment)
      )
    ) {
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
