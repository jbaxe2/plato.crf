library plato.angular.models.crf.requested_section;

import '../banner/section.dart';

import '../learn/cross_listing.dart';

import 'previous_content_mapping.dart';

/// The [RequestedSection] class...
class RequestedSection {
  final Section section;

  CrossListing crossListing;

  PreviousContentMapping previousContent;

  bool get hasCrossListing => (null == crossListing);

  bool get hasPreviousContent => (null == previousContent);

  /// The [RequestedSection] constructor...
  RequestedSection (this.section);

  void setCrossListing (CrossListing aCrossListing) {
    ;
  }
}
