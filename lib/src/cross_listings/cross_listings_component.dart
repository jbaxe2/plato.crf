library plato.crf.components.cross_listings;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/workflow/workflow_service.dart';

import '../sections/section.dart';

import 'cross_listing.dart';
import 'cross_listing_component.dart';
import 'cross_listing_service.dart';

/// The [CrossListingsComponent] class...
@Component(
  selector: 'cross-listings',
  templateUrl: 'cross_listings_component.html',
  styleUrls: const ['cross_listings_component.css'],
  directives: const [
    ModalComponent, MaterialDialogComponent, MaterialButtonComponent,
    MaterialIconComponent, NgIf, NgFor,
    CrossListingComponent
  ],
  providers: const [CrossListingService]
)
class CrossListingsComponent implements OnInit {
  List<CrossListing> crossListings;

  Section invokerSection;

  bool isVisible;

  final CrossListingService _crossListingService;

  final WorkflowService _workflowService;

  /// The [CrossListingsComponent] constructor...
  CrossListingsComponent (this._crossListingService, this._workflowService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit ()  {
    crossListings = _crossListingService.crossListings;
    isVisible = false;

    _crossListingService.sectionsStreamer.stream.listen (
      (Section section) {
        crossListings.removeWhere (
          (CrossListing crossListing) => crossListing.sections.isEmpty
        );

        invokerSection = section;
        isVisible = true;
      }
    );

    _workflowService.markCrossListingsHandled();
  }

  /// The [createNewCrossListingSet] method...
  void createNewCrossListingSet() {
    try {
      _crossListingService.createCrossListingSet();
    } catch (_) {}
  }

  /// The [confirmCrossListings] method...
  void confirmCrossListings() {
    try {
      _crossListingService.confirmCrossListings();
      isVisible = false;
    } catch (_) {}
  }
}
