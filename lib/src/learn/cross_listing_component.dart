library plato.angular.components.learn.cross_listing;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../banner/section.dart';

import 'cross_listing.dart';
import 'cross_listing_service.dart';

/// The [CrossListingComponent] class...
@Component(
  selector: 'cross-listing',
  templateUrl: 'cross_listing_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [CrossListingService]
)
class CrossListingComponent implements OnInit {
  CrossListing crossListing;

  List<Section> sections;

  final CrossListingService _crossListingService;

  /// The [CrossListingComponent] method...
  CrossListingComponent (this._crossListingService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    crossListing = _crossListingService.createCrossListingSet();
    sections = crossListing.sections;
  }

  /// The [addSectionToCrossListing] method...
  void addSectionToCrossListing (Section aSection) {
    try {
      _crossListingService.addSectionToCrossListing (aSection, crossListing);
    } catch (_) {
      rethrow;
    }
  }
}
