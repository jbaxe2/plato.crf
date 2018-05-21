library plato.crf.components.section.info;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../cross_listings/cross_listing.dart';
import '../../cross_listings/cross_listing_service.dart';

import '../../previous_content/previous_content_mapping.dart';
import '../../previous_content/previous_content_service.dart';

import '../section.dart';

import 'requested_sections_service.dart';

/// The [RequestedSectionComponent] class...
@Component(
  selector: 'requested-section',
  templateUrl: 'requested_section_component.html',
  styleUrls: const ['requested_section_component.css'],
  directives: const [coreDirectives, materialDirectives],
  providers: const [
    RequestedSectionsService, CrossListingService, PreviousContentService
  ],
  pipes: const [SlicePipe]
)
class RequestedSectionComponent implements OnInit {
  @Input()
  Section section;

  CrossListing _crossListing;

  CrossListing get crossListing => _crossListing;

  bool get hasCrossListing => (null != _crossListing);

  PreviousContentMapping _previousContent;

  PreviousContentMapping get previousContent => _previousContent;

  bool get hasPreviousContent => (null != _previousContent);

  bool get hasExtraInfo => (hasCrossListing || hasPreviousContent);

  final RequestedSectionsService _reqSectionsService;

  final CrossListingService _crossListingService;

  final PreviousContentService _previousContentService;

  /// The [RequestedSectionComponent] constructor...
  RequestedSectionComponent (
    this._reqSectionsService, this._crossListingService, this._previousContentService
  );

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _crossListingService.crossListingStreamer.stream.listen (
      (CrossListing aCrossListing) => _updateCrossListingInfo (aCrossListing)
    );

    _previousContentService.previousContentStreamer.stream.listen (
      (PreviousContentMapping aPreviousContent) =>
        _updatePreviousContentInfo (aPreviousContent)
    );
  }

  /// The [addToCrossListing] method...
  void addToCrossListing() => _crossListingService.invokeForSection (section);

  /// The [copyPreviousContent] method...
  void copyPreviousContent() => _previousContentService.invokeForSection (section);

  /// The [removeSection] method...
  void removeSection() {
    _reqSectionsService.removeSection (section);

    _crossListing = null;
    _previousContent = null;
  }

  /// The [removeFromCrossListing] method...
  void removeFromCrossListing() {
    _crossListingService.removeSectionFromCrossListing (section, crossListing);
    _crossListing = null;
    _confirmFeaturedOptions();
  }

  /// The [removePreviousContent] method...
  void removePreviousContent() {
    _previousContentService.removePreviousContent (previousContent);
    _previousContent = null;
    _confirmFeaturedOptions();
  }

  /// The [_confirmFeaturedOptions] method...
  void _confirmFeaturedOptions() {
    _crossListingService.confirmCrossListings();
    _previousContentService.confirmPreviousContents();
  }

  /// The [_updateCrossListingInfo] method...
  void _updateCrossListingInfo (CrossListing theCrossListing) {
    if (null == theCrossListing) {
      _crossListing = null;

      return;
    }

    if (theCrossListing == crossListing) {
      return;
    }

    if (theCrossListing.sections.contains (section)) {
      _crossListing = theCrossListing;
      _confirmFeaturedOptions();
    } else {
      bool crossListingEmpty = _crossListing?.sections?.isEmpty;

      if ((theCrossListing == _crossListing) || crossListingEmpty) {
        _crossListing = null;
      }
    }
  }

  /// The [_updatePreviousContentInfo] method...
  void _updatePreviousContentInfo (PreviousContentMapping thePreviousContent) {
    if (null == thePreviousContent) {
      _previousContent = null;

      return;
    }

    if (thePreviousContent == previousContent) {
      return;
    }

    if (thePreviousContent.section == section) {
      _previousContent = thePreviousContent;
      _confirmFeaturedOptions();
    }
  }
}
