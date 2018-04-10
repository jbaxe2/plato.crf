library plato.angular.models.course_request;

import '../cross_listings/cross_listing.dart';
import '../cross_listings/cross_listing_exception.dart';

import '../enrollments/enrollment.dart';

import '../previous_content/previous_content_mapping.dart';
import '../previous_content/previous_content_exception.dart';

import '../sections/requested/requested_section.dart';
import '../sections/requested/requested_section_factory.dart';

import '../sections/section.dart';
import '../sections/section_exception.dart';

import '../user/user_exception.dart';
import '../user/user_information.dart';

/// The [CourseRequest] class...
class CourseRequest {
  UserInformation _userInformation;

  UserInformation get userInformation => _userInformation;

  List<Section> sections;

  List<CrossListing> crossListings;

  List<PreviousContentMapping> previousContents;

  bool get submittable => (null != _userInformation) && sections.isNotEmpty;

  static CourseRequest _instance;

  /// The [CourseRequest] factory constructor...
  factory CourseRequest() =>
    _instance ?? (_instance = new CourseRequest._());

  /// The [CourseRequest] private constructor...
  CourseRequest._() {
    sections = new List<Section>();
    crossListings = new List<CrossListing>();
    previousContents = new List<PreviousContentMapping>();
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
    CrossListing crossListing = getCrossListingForSection (aSection);
    PreviousContentMapping previousContent = getPreviousContentForSection (aSection);

    if (null != crossListing) {
      removeSectionFromCrossListing (aSection, getCrossListingForSection (aSection));
    }

    if (null != previousContent) {
      removePreviousContentForSection (aSection);
    }

    return sections.remove (aSection);
  }

  /// The [removeAllSections] method...
  void removeAllSections() => removeSections (new List.from (sections));

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
    _normalizePcAddedForClSection (aSection);
  }

  /// The [removeSectionFromCrossListing] method...
  bool removeSectionFromCrossListing (Section aSection, CrossListing aCrossListing) {
    bool sectionRemoved = aCrossListing.removeSection (aSection);

    if (aCrossListing.sections.isEmpty) {
      removeCrossListing (aCrossListing);
    }

    return sectionRemoved;
  }

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

  /// The [getCrossListingForSection] method...
  CrossListing getCrossListingForSection (Section aSection) {
    CrossListing crossListing;

    try {
      crossListing = crossListings.firstWhere (
        (CrossListing aCrossListing) => aCrossListing.contains (aSection)
      );
    } catch (_) {}

    return crossListing;
  }

  /// The [getPreviousContentForSection] method...
  PreviousContentMapping getPreviousContentForSection (Section section) {
    PreviousContentMapping previousContent;

    try {
      previousContent = previousContents.firstWhere (
        (PreviousContentMapping aPreviousContent) =>
          (aPreviousContent.section == section)
      );
    } catch (_) {}

    return previousContent;
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
    _normalizePcAddedForClSection (aPreviousContent.section);
  }

  /// The [removePreviousContent] method...
  void removePreviousContent (PreviousContentMapping aPreviousContent) {
    Section pcSection = aPreviousContent.section;

    previousContents.removeWhere (
      (PreviousContentMapping previousContent) => (previousContent == aPreviousContent)
    );

    _normalizePcRemovedForClSection (pcSection);
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
    _normalizePcAddedForClSection (thePreviousContent.section);
  }

  /// The [removePreviousContentForSection] method...
  void removePreviousContentForSection (Section theSection) {
    previousContents.remove (getPreviousContentForSection (theSection));
  }

  /// The [_normalizePcAddedForClSection] method...
  void _normalizePcAddedForClSection (Section aSection) {
    CrossListing crossListing = getCrossListingForSection (aSection);

    if ((null != crossListing) && (1 < crossListing.sections.length)) {
      PreviousContentMapping previousContent = getPreviousContentForSection (aSection);

      if (null == previousContent) {
        _normalizeNullPcAdded (aSection, crossListing);
      } else {
        _normalizeNotNullPcAdded (aSection, crossListing, previousContent);
      }
    }
  }

  /// The [_normalizeNullPcAdded] method...
  void _normalizeNullPcAdded (Section aSection, CrossListing aCrossListing) {
    PreviousContentMapping clPreviousContent = getPreviousContentForSection (
      aCrossListing.sections.firstWhere (
        (Section clSection) => (clSection != aSection)
      )
    );

    if (null != clPreviousContent) {
      var prevContent = new PreviousContentMapping (
        aSection, clPreviousContent.enrollment
      );

      addPreviousContentMapping (prevContent);
    }
  }

  /// The [_normalizeNotNullPcAdded] method...
  void _normalizeNotNullPcAdded (
    Section aSection, CrossListing aCrossListing, PreviousContentMapping aPreviousContent
  ) {
    aCrossListing.sections.forEach ((Section clSection) {
      if (clSection == aSection) {
        return;
      }

      PreviousContentMapping clPreviousContent =
        getPreviousContentForSection (clSection);

      if (null == clPreviousContent) {
        var prevContent = new PreviousContentMapping (
          clSection, aPreviousContent.enrollment
        );

        addPreviousContentMapping (prevContent);
      }

      if ((null != clPreviousContent) &&
          (clPreviousContent.enrollment != aPreviousContent.enrollment)) {
        setPreviousContentEnrollment (clPreviousContent, aPreviousContent.enrollment);
      }
    });
  }

  /// The [_normalizePcRemovedForClSection] method...
  void _normalizePcRemovedForClSection (Section aSection) {
    CrossListing crossListing = getCrossListingForSection (aSection);

    if (null != crossListing) {
      crossListing.sections.forEach ((Section clSection) {
        removePreviousContentForSection (clSection);
      });
    }
  }

  /// The [verify] method...
  bool verify() {
    if (null == userInformation) {
      throw new UserException (
        'No user information has been provided to submit the course request.'
      );
    }

    if (sections.isEmpty) {
      throw new SectionException (
        'No sections have been selected for this course request.'
      );
    }

    crossListings.forEach ((CrossListing crossListing) {
      if (crossListing.sections.length < 2) {
        throw new CrossListingException (
          'Cannot have a cross-listing set with only one section.'
        );
      }

      if (!crossListing.sections.every (
        (Section section) => (sections.contains (section))
      )) {
        throw new CrossListingException (
          'Cannot have a cross-listing set containing a section which is not '
            'part of the course request.'
        );
      }
    });

    previousContents.forEach ((PreviousContentMapping previousContent) {
      if (!sections.contains (previousContent.section)) {
        throw new PreviousContentException (
          'Cannot have previous content specified for a section that is not part '
            'of the course request.'
        );
      };
    });

    return true;
  }

  /// The [toJson] method...
  Object toJson() {
    return {
      'userInfo': _userInformation,
      'sections': sections,
      'crossListings': crossListings,
      'requestedSections': _buildRequestedSections(),
      'context': _userInformation.isLtiSession
    };
  }

  /// The [_buildRequestedSections] method...
  List<RequestedSection> _buildRequestedSections() {
    var requestedSectionFactory = new RequestedSectionFactory()
      ..setSections (sections)
      ..setCrossListings (crossListings)
      ..setPreviousContents (previousContents);

    return requestedSectionFactory.build();
  }
}
