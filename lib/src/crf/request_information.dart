library plato.angular.models.crf.request_information;

import '../banner/section.dart';

import '../crf/previous_content_mapping.dart';

import '../learn/cross_listing.dart';

import '../user/user_information.dart';

/// The [RequestInformation] class...
class RequestInformation {
  final UserInformation userInformation;

  List<Section> sections;

  List<CrossListing> crossListings;

  List<PreviousContentMapping> previousContents;

  /// The [RequestInformation] constructor...
  RequestInformation (this.userInformation) {
    sections = new List<Section>();
    crossListings = new List<CrossListing>();
    previousContents = new List<PreviousContentMapping>();
  }

  /// The [addSections] method...
  void addSections (List<Section> someSections) {
    someSections.forEach ((Section aSection) => addSection (aSection));
  }

  /// The [addSection] method...
  void addSection (Section aSection) {
    if (!sections.contains (aSection)) {
      sections.add (aSection);
    }
  }

  /// The [removeSections] method...
  bool removeSections (List<Section> someSections) {
    return someSections.every ((Section aSection) => removeSection (aSection));
  }

  /// The [removeSection] method...
  bool removeSection (Section aSection) {
    crossListings.forEach ((CrossListing crossListing) {
      crossListing.sections.removeWhere ((Section section) => aSection == section);
    });

    return sections.remove (aSection);
  }

  /// The [addCrossListings] method...
  void addCrossListings (List<CrossListing> someCrossListings) {
    someCrossListings.forEach (
      (CrossListing aCrossListing) => addCrossListing (aCrossListing)
    );
  }

  /// The [addCrossListing] method...
  void addCrossListing (CrossListing aCrossListing) {
    if (!crossListings.contains (aCrossListing)) {
      aCrossListing.sections.any ((Section section) {
        ;
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
  bool removeCrossListing (CrossListing aCrossListing) =>
    crossListings.remove (aCrossListing);
}
