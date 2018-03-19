library plato.angular.components.cross_listings;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato_angular/src/sections/section.dart';

import 'cross_listing.dart';
import 'cross_listing_component.dart';
import 'cross_listing_service.dart';

/// The [CrossListingsComponent] class...
@Component(
  selector: 'cross-listings',
  templateUrl: 'cross_listings_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, CrossListingComponent],
  providers: const [CrossListingService]
)
class CrossListingsComponent implements OnInit {
  List<CrossListing> crossListings;

  Section invokerSection;

  bool isVisible;

  final CrossListingService _crossListingService;

  /// The [CrossListingsComponent] constructor...
  CrossListingsComponent (this._crossListingService);

  /// The [ngOnInit] method...
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
