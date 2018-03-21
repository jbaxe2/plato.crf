library plato.angular.models.crf.request_information;

import '../cross_listings/cross_listing.dart';
import '../cross_listings/cross_listing_exception.dart';

import '../enrollments/enrollment.dart';

import '../previous_content/previous_content_mapping.dart';
import '../previous_content/previous_content_exception.dart';

import '../sections/section.dart';
import '../sections/requested_section.dart';

import '../user/user_exception.dart';
import '../user/user_information.dart';

/// The [RequestInformation] class...
class RequestInformation {
  UserInformation _userInformation;

  UserInformation get userInformation => _userInformation;

  List<Section> sections;

  List<CrossListing> crossListings;

  List<PreviousContentMapping> previousContents;

  Map<Section, RequestedSection> requestedSections;

  bool get submittable => (null != _userInformation) && sections.isNotEmpty;

  static RequestInformation _instance;

  /// The [RequestInformation] factory constructor...
  factory RequestInformation() =>
    _instance ?? (_instance = new RequestInformation._());

  /// The [RequestInformation] private constructor...
  RequestInformation._() {
    sections = new List<Section>();
    crossListings = new List<CrossListing>();
    previousContents = new List<PreviousContentMapping>();

    requestedSections = new Map<Section, RequestedSection>();
  }

  /// The [setUserInformation] method...
  void setUserInformation (UserInformation theUserInformation) {
    if (null != userInformation) {
      throw new UserException ('Cannot add the user information more than once.');
    }

    _userInformation = theUserInformation;
  }

  /// The [addSections] method...
  void addSections (List<Section> someSections) {
    someSections.forEach ((Section aSection) => addSection (aSection));
  }

  /// The [addSection] method...
  void addSection (Section aSection) {
    if (!sections.contains (aSection)) {
      sections.add (aSection);
      sections.sort();
    }
  }

  /// The [removeSections] method...
  bool removeSections (List<Section> someSections) {
    return someSections.every ((Section aSection) => removeSection (aSection));
  }

  /// The [removeSection] method...
  bool removeSection (Section aSection) {
    CrossListing crossListing;

    try {
      crossListing = crossListings.firstWhere (
        (CrossListing someCrossListing) => someCrossListing.contains (aSection)
      );
    } catch (_) {}

    removeSectionFromCrossListing (aSection, crossListing);

    previousContents.removeWhere (
      (PreviousContentMapping previousContent) => aSection == previousContent.section
    );

    return sections.remove (aSection);
  }

  /// The [addCrossListings] method...
  void addCrossListings (List<CrossListing> someCrossListings) {
    try {
      someCrossListings.forEach (
        (CrossListing aCrossListing) => addCrossListing (aCrossListing)
      );
    } catch (_) {
      rethrow;
    }
  }

  /// The [addCrossListing] method...
  void addCrossListing (CrossListing aCrossListing) {
    if (
      crossListings.any ((CrossListing crossListing) => !crossListing.isValid)
    ) {
      throw new CrossListingException (
        'Cannot add a new cross-listing set when a different set is not valid.'
      );
    }

    if (!crossListings.contains (aCrossListing)) {
      crossListings.forEach ((CrossListing crossListing) {
        aCrossListing.sections.forEach ((Section section) {
          if (crossListing.contains (section)) {
            throw new CrossListingException (
              'The provided cross-listing set contains a section that is '
              'already part of another cross-listing set.'
            );
          }
        });
      });

      crossListings.add (aCrossListing);
    }
  }

  /// The [removeCrossListings] method...
  bool removeCrossListings (List<CrossListing> someCrossListings) {
    return someCrossListings.every (
      (CrossListing aCrossListing) => removeCrossListing (aCrossListing)
    );
  }

  /// The [removeCrossListing] method...
  bool removeCrossListing (CrossListing aCrossListing) {
    try {
      var clSections = new List<Section>.from (aCrossListing.sections);

      clSections.forEach ((Section aSection) {
        removeSectionFromCrossListing (aSection, aCrossListing);
      });

      return crossListings.remove (aCrossListing);
    } catch (_) {}

    return false;
  }

  /// The [addSectionToCrossListing] method...
  void addSectionToCrossListing (Section aSection, CrossListing aCrossListing) {
    try {
      _checkCrossListingConditions (aSection, aCrossListing);
    } catch (_) {
      rethrow;
    }

    aCrossListing.addSection (aSection);
  }

  /// The [removeSectionFromCrossListing] method...
  bool removeSectionFromCrossListing (Section aSection, CrossListing aCrossListing) =>
    aCrossListing?.removeSection (aSection);

  /// The [_checkCrossListingConditions] method...
  bool _checkCrossListingConditions (Section aSection, CrossListing aCrossListing) {
    if (!crossListings.contains (aCrossListing)) {
      throw new CrossListingException (
        'The specified cross-listing is not part of the request information.'
      );
    }

    crossListings.forEach ((CrossListing crossListing) {
      if (crossListing.contains (aSection) && (aCrossListing != crossListing)) {
        throw new CrossListingException (
          'The specified section is part of a different cross-listing set.'
        );
      }
    });

    return true;
  }

  /// The [addPreviousContentMappings] method...
  void addPreviousContentMappings (List<PreviousContentMapping> somePreviousContents) {
    somePreviousContents.forEach (
      (PreviousContentMapping previousContent) => addPreviousContentMapping (previousContent)
    );
  }

  /// The [addPreviousContentMapping] method...
  void addPreviousContentMapping (PreviousContentMapping aPreviousContent) {
    if (previousContents.any (
      (PreviousContentMapping previousContent) =>
        (previousContent.section == aPreviousContent.section)
    )) {
      throw new PreviousContentException (
        'Cannot add a previous content mapping for a section that already '
        'contains other previous content.'
      );
    }

    previousContents.add (aPreviousContent);
  }

  /// The [removePreviousContent] method...
  void removePreviousContent (PreviousContentMapping aPreviousContent) {
    previousContents.removeWhere (
      (PreviousContentMapping previousContent) => (previousContent == aPreviousContent)
    );
  }

  /// The [setPreviousContentEnrollment] method...
  void setPreviousContentEnrollment (
    PreviousContentMapping thePreviousContent, Enrollment enrollment
  ) {
    if (!previousContents.contains (thePreviousContent)) {
      throw new PreviousContentException (
        'The previous content specified is not attached to any requested section.'
      );
    }

    thePreviousContent.enrollment = enrollment;
  }

  /// The [removePreviousContentForSection] method...
  void removePreviousContentForSection (Section theSection) {
    ;
  }

  /// The [verify] method...
  bool verify() {
    return false;
  }

  /// The [toJson] method...
  Object toJson() {
    return {};
  }
}
