library plato.angular.services.crf.request_information;

import 'dart:async' show Future;

import 'package:http/http.dart' show Client, Response;

import 'package:angular/core.dart';

import '../banner/section.dart';

import '../crf/previous_content_mapping.dart';

import '../learn/cross_listing.dart';
import '../learn/enrollment.dart';

import '../user/user_information.dart';

import 'crf_exception.dart';
import 'request_information.dart';

const String _SUBMISSION_URI = '/plato/submit/crf';

@Injectable()
/// The [CourseRequestService] class...
class CourseRequestService {
  RequestInformation requestInformation;

  final Client _http;

  static CourseRequestService _instance;

  /// The [CourseRequestService] factory constructor...
  factory CourseRequestService (Client http) =>
    _instance ?? (_instance = new CourseRequestService._ (http));

  /// The [CourseRequestService] private constructor...
  CourseRequestService._ (this._http);

  /// The [createRequestInformation] method...
  void createRequestInformation (UserInformation userInfo) {
    requestInformation = new RequestInformation (userInfo);
  }

  /// The [addSections] method...
  void addSections (List<Section> sections) => requestInformation.addSections (sections);

  /// The [removeSection] method...
  void removeSection (Section section) => requestInformation.removeSection (section);

  /// The [createCrossListingSet] method...
  CrossListing createCrossListingSet() {
    var crossListing = new CrossListing();

    try {
      requestInformation.addCrossListing (crossListing);
    } catch (_) { rethrow; }

    return crossListing;
  }

  /// The [createPreviousContent] method...
  PreviousContentMapping createPreviousContent (Section section, Enrollment enrollment) {
    var previousContent = new PreviousContentMapping (section, enrollment);

    try {
      requestInformation.addPreviousContentMapping (previousContent);
    } catch (_) { rethrow; }

    return previousContent;
  }

  /// The [validateCrf] method...
  void validateCrf() {
    if (null == requestInformation) {
      throw new CrfException ('Cannot submit a course request that does not exist.');
    }

    if (null == requestInformation.userInformation) {
      throw new CrfException (
        'No user information has been provided to submit the course request.'
      );
    }

    if (requestInformation.sections.isEmpty) {
      throw new CrfException ('No sections have been selected for this course request.');
    }

    requestInformation.crossListings.forEach ((CrossListing crossListing) {
      if (crossListing.sections.length < 2) {
        throw new CrfException ('Cannot have a cross-listing set with only one section.');
      }

      if (!crossListing.sections.every (
        (Section section) => (requestInformation.sections.contains (section))
      )) {
        throw new CrfException (
          'Cannot have a cross-listing set containing a section which is not '
          'part of the course request.'
        );
      }
    });

    requestInformation.previousContents.forEach ((PreviousContentMapping previousContent) {
      if (!requestInformation.sections.contains (previousContent.section)) {
        throw new CrfException (
          'Cannot have previous content specified for a section that is not part '
          'of the course request.'
        );
      };
    });
  }

  /// The [submitCrf] method...
  Future submitCrf() async {
    try {
      validateCrf();
    } catch (_) { rethrow; }

    try {
      final Response crfResponse = await _http.post (_SUBMISSION_URI);

      crfResponse.body;
    } catch (_) {
      throw new CrfException (
        'An error has occurred while attempting to submit the course request.'
      );
    }
  }
}
