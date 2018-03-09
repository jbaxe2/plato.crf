library plato.angular.services.learn.previous_content;

import 'package:angular/core.dart';

import '../banner/section.dart';

import '../crf/request_information.dart';

import '../learn/enrollment.dart';

import 'previous_content_mapping.dart';

/// The [PreviousContentService] class...
@Injectable()
class PreviousContentService {
  List<PreviousContentMapping> previousContents;

  RequestInformation _requestInformation;

  static PreviousContentService _instance;

  /// The [PreviousContentService] factory constructor...
  factory PreviousContentService() =>
    _instance ?? (_instance = new PreviousContentService._());

  /// The [PreviousContentService] private constructor...
  PreviousContentService._() {
    _requestInformation = new RequestInformation();
    previousContents = _requestInformation.previousContents;
  }

  /// The [createPreviousContent] method...
  PreviousContentMapping createPreviousContent (Section section, Enrollment enrollment) {
    var previousContent = new PreviousContentMapping (section, enrollment);

    try {
      _requestInformation.addPreviousContentMapping (previousContent);
    } catch (_) { rethrow; }

    return previousContent;
  }
}
