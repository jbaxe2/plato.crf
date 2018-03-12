library plato.angular.components.learn.cross_listings;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../banner/section.dart';

import 'cross_listing.dart';
import 'cross_listing_service.dart';

/// The [CrossListingsComponent] class...
@Component(
    selector: 'cross-listings',
    templateUrl: 'cross_listings_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    providers: const [CrossListingService]
)
class CrossListingsComponent implements OnInit {
  List<CrossListing> crossListings;

  Section invokerSection;

  final CrossListingService _crossListingService;

  /// The [CrossListingsComponent] constructor...
  CrossListingsComponent (this._crossListingService);

  /// The [ngOnInit] method...
  void ngOnInit ()  {
    crossListings = _crossListingService.crossListings;
    invokerSection = _crossListingService.invokerSection;
  }

  /// The [createNewCrossListingSet] method...
  void createNewCrossListingSet() {
    _crossListingService.createCrossListingSet();
  }

  /// The [confirmCrossListings] method...
  void confirmCrossListings() => _crossListingService.revokeSection();
}
