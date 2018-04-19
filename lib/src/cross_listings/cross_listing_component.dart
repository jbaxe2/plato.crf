library plato.angular.components.cross_listing;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../sections/section.dart';

import 'cross_listing.dart';
import 'cross_listing_service.dart';

/// The [CrossListingComponent] class...
@Component(
  selector: 'cross-listing',
  templateUrl: 'cross_listing_component.html',
  styleUrls: const [
    'package:angular_components/app_layout/layout.scss.css'
  ],
  directives: const [coreDirectives, materialDirectives],
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

  bool get hasInvokerSection => crossListing.contains (invokerSection);

  final CrossListingService _crossListingService;

  /// The [CrossListingComponent] constructor...
  CrossListingComponent (this._crossListingService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (sections = crossListing.sections);

  /// The [addSectionToCrossListing] method...
  void addSectionToCrossListing() {
    try {
      _crossListingService.addSectionToCrossListing (invokerSection, crossListing);
    } catch (_) {}
  }

  /// The [removeSectionFromCrossListing] method...
  void removeSectionFromCrossListing() {
    try {
      _crossListingService.removeSectionFromCrossListing (invokerSection, crossListing);
    } catch (_) {}
  }

  /// The [removeCrossListing] method...
  bool removeCrossListing() {
    try {
      _crossListingService.removeCrossListing (crossListing);
    } catch (_) {}

    return false;
  }
}
