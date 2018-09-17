library plato.crf.components.cross_listing.modifier;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../course_request/course_request_service.dart';

import '../sections/section.dart';

import 'cross_listing.dart';
import 'cross_listing_service.dart';

/// The [CrossListingModifierComponent] class...
@Component(
  selector: 'cross-listing-modifier',
  templateUrl: 'cross_listing_modifier_component.html',
  styleUrls: const ['cross_listing_modifier_component.css'],
  directives: const [
    ModalComponent, MaterialDialogComponent, MaterialCheckboxComponent,
    MaterialButtonComponent, NgFor, NgIf
  ],
  providers: const [CourseRequestService, CrossListingService]
)
class CrossListingModifierComponent implements OnInit {
  bool isVisible;

  @Input()
  CrossListing crossListing;

  List<Section> requestedSections;

  List<Section> _selectedSections;

  final CourseRequestService _courseRequestService;

  final CrossListingService _crossListingService;

  /// The [CrossListingModifierComponent] constructor...
  CrossListingModifierComponent (
    this._courseRequestService, this._crossListingService
  ) {
    isVisible = false;

    requestedSections = new List<Section>();
    _selectedSections = new List<Section>();
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (requestedSections = _courseRequestService.requestedSections);

  /// The [sectionHasCrossListing] method...
  bool sectionHasCrossListing (Section section) =>
    _courseRequestService.sectionHasCrossListing (section);

  /// The [sectionInOtherCrossListing] method...
  bool sectionInOtherCrossListing (Section section) =>
    sectionHasCrossListing (section) && !crossListing.contains (section);

  /// The [handleCrossListingSection] method...
  void handleCrossListingSection (Section section, bool checked) {
    if (checked && !_selectedSections.contains (section)) {
      _selectedSections.add (section);
    } else {
      _selectedSections.remove (section);
    }
  }

  /// The [modifyCrossListingSet] method...
  void modifyCrossListingSet() {
    _selectedSections.forEach ((Section section) {
      _crossListingService.addSectionToCrossListing (section, crossListing);
    });

    List<Section> removedSections = crossListing.sections.where (
      (Section section) => !_selectedSections.contains (section)
    );

    removedSections.forEach ((Section section) {
      _crossListingService.removeSectionFromCrossListing (section, crossListing);
    });

    _crossListingService.confirmCrossListings();
    _selectedSections.clear();

    isVisible = false;
  }
}
