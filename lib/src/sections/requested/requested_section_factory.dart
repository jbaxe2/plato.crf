library plato.angular.factory.section.requested;

import '../../_application/factory/plato_factory.dart';

import '../../cross_listings/cross_listing.dart';
import '../../cross_listings/cross_listing_exception.dart';

import '../../previous_content/previous_content_mapping.dart';
import '../../previous_content/previous_content_exception.dart';

import '../section.dart';

import 'requested_section.dart';
import 'requested_section_exception.dart';

/// The [RequestedSectionFactory] class...
class RequestedSectionFactory implements PlatoFactory<RequestedSection> {
  List<Section> _sections;

  List<CrossListing> _crossListings;

  List<PreviousContentMapping> _previousContents;

  /// The [RequestedSectionFactory] constructor...
  RequestedSectionFactory();

  /// The [setSections] method...
  void setSections (List<Section> sections) => _sections = sections;

  /// The [setCrossListings] method...
  void setCrossListings (List<CrossListing> crossListings) =>
    _crossListings = crossListings;

  /// The [setPreviousContents] method...
  void setPreviousContents (List<PreviousContentMapping> previousContents) =>
    _previousContents = previousContents;

  /// The [create] method...
  @override
  RequestedSection create (Map<String, dynamic> rawRequestedSection) {
    if (!(rawRequestedSection.containsKey ('section') &&
          rawRequestedSection.containsKey ('crossListing') &&
          rawRequestedSection.containsKey ('previousContent'))) {
      throw new RequestedSectionException (
        'Information relating to the requested section was improperly formatted.'
      );
    }

    if (!_sections.contains (rawRequestedSection['section'])) {
      throw new RequestedSectionException (
        'The provided section is not part of the list of requested sections.'
      );
    }

    if ((null != rawRequestedSection['crossListing']) &&
        !_crossListings.contains (rawRequestedSection['crossListing'])) {
      throw new CrossListingException (
        'The provided cross-listing is not part of the list of cross-listing sets.'
      );
    }

    if ((null != rawRequestedSection['previousContent']) &&
        !_previousContents.contains (rawRequestedSection['previousContent'])) {
      throw new PreviousContentException (
        'The provided previous content is not available to use for the requested section.'
      );
    }

    Section section = rawRequestedSection['section'] as Section;

    return new RequestedSection (section)
      ..setCrossListing (_getCrossListingForSection (section))
      ..setPreviousContent (_getPreviousContentForSection (section));
  }

  /// The [createAll] method...
  @override
  List<RequestedSection> createAll (Iterable<Map<String, dynamic>> rawRequestedSections) {
    var requestedSections = new List<RequestedSection>();

    try {
      rawRequestedSections.forEach ((Map<String, dynamic> rawRequestedSection) {
        requestedSections.add (create (rawRequestedSection));
      });
    } catch (_) {
      rethrow;
    }

    return requestedSections;
  }

  /// The [build] method...
  List<RequestedSection> build() {
    var requestedSections = new List<RequestedSection>();
    var rawRequestedSections = new List<Map<String, dynamic>>();

    _sections.forEach ((Section section) {
      Map<String, dynamic> rawRequestedSection = {
        'section': section,
        'crossListing': _getCrossListingForSection (section),
        'previousContent': _getPreviousContentForSection (section)
      };

      rawRequestedSections.add (rawRequestedSection);
    });

    return (requestedSections..addAll (createAll (rawRequestedSections)));
  }

  /// The [_getCrossListingForSection] method...
  CrossListing _getCrossListingForSection (Section section) {
    CrossListing crossListing;

    try {
      crossListing = _crossListings.firstWhere (
        (CrossListing aCrossListing) => aCrossListing.contains (section)
      );
    } catch (_) {}

    return crossListing;
  }

  /// The [_getPreviousContentForSection] method...
  PreviousContentMapping _getPreviousContentForSection (Section section) {
    PreviousContentMapping previousContent;

    try {
      previousContent = _previousContents.firstWhere (
        (PreviousContentMapping aPreviousContent) =>
          (aPreviousContent.section == section)
      );
    } catch (_) {}

    return previousContent;
  }
}
