library plato.angular.models.crf.requested_section;

import '../banner/section.dart';

import '../learn/cross_listing.dart';

import 'previous_content_mapping.dart';

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
    if (aCrossListing.contains (section)) {
      _crossListing = aCrossListing;
    }
  }

  /// The [setPreviousContent] method...
  void setPreviousContent (PreviousContentMapping aPreviousContent) {
    if (aPreviousContent.section == section) {
      _previousContent = aPreviousContent;
    }
  }
}
