library plato.angular.components.banner.section.info;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../banner/section.dart';

import '../learn/cross_listing.dart';
import '../learn/cross_listing_service.dart';
import '../learn/previous_content_mapping.dart';
import '../learn/previous_content_service.dart';

import 'requested_sections_service.dart';

/// The [RequestedSectionComponent] class...
@Component(
  selector: 'requested-section',
  templateUrl: 'requested_section_component.html',
  styleUrls: const ['requested_section_component.scss.css'],
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [
    RequestedSectionsService, CrossListingService, PreviousContentService
  ]
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
  void ngOnInit() {
    _crossListingService.crossListingStreamer.stream.listen (
      (CrossListing crossListing) => _updateCrossListingInfo (crossListing)
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
  }

  /// The [_updateCrossListingInfo] method...
  void _updateCrossListingInfo (CrossListing crossListing) {
    if (null == crossListing) {
      _crossListing = null;

      return;
    }

    if (crossListing.sections.contains (section)) {
      _crossListing = crossListing;
    } else {
      if (crossListing == _crossListing) {
        _crossListing = null;
      }
    }
  }

  /// The [_updatePreviousContentInfo] method...
  void _updatePreviousContentInfo (PreviousContentMapping previousContent) {
    if (null == previousContent) {
      _previousContent = null;

      return;
    }

    if (previousContent.section == section) {
      _previousContent = previousContent;
    }
  }
}
