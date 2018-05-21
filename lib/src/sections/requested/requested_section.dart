library plato.crf.models.section.requested;

import '../../cross_listings/cross_listing.dart';

import '../../previous_content/previous_content_mapping.dart';

import '../section.dart';

/// The [RequestedSection] class...
class RequestedSection {
  final Section section;

  CrossListing _crossListing;

  CrossListing get crossListing => _crossListing;

  PreviousContentMapping _previousContent;

  PreviousContentMapping get previousContent => _previousContent;

  bool get hasCrossListing => (null != _crossListing);

  bool get hasPreviousContent => (null != _previousContent);

  /// The [RequestedSection] constructor...
  RequestedSection (this.section);

  /// The [setCrossListing] method...
  void setCrossListing (CrossListing aCrossListing) {
    if (null == aCrossListing) {
      return;
    }

    if (aCrossListing.contains (section)) {
      _crossListing = aCrossListing;
    }
  }

  /// The [setPreviousContent] method...
  void setPreviousContent (PreviousContentMapping aPreviousContent) {
    if (null == aPreviousContent) {
      return;
    }

    if (aPreviousContent.section == section) {
      _previousContent = aPreviousContent;
    }
  }

  /// The [toJson] method...
  Object toJson() {
    return {
      'section': section,
      'crossListing': crossListing,
      'previousContent': previousContent
    };
  }
}
