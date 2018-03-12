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
  @Input()
  CrossListing crossListing;

  List<Section> sections;

  @Input()
  Section invokerSection;

  @Input()
  int setNumber;

  final CrossListingService _crossListingService;

  /// The [CrossListingComponent] method...
  CrossListingComponent (this._crossListingService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    sections = crossListing.sections;
  }

  /// The [addSectionToCrossListing] method...
  void addSectionToCrossListing() =>
    _crossListingService.addSectionToCrossListing (invokerSection, crossListing);

  /// The [removeSectionFromCrossListing] method...
  void removeSectionFromCrossListing() =>
    _crossListingService.removeSectionFromCrossListing (invokerSection, crossListing);

  /// The [removeCrossListing] method...
  bool removeCrossListing() =>
    _crossListingService.removeCrossListing (crossListing);
}
