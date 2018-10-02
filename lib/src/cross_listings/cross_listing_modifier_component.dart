library plato.crf.components.cross_listing.modifier;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/workflow/workflow_service.dart';

import '../course_request/course_request_service.dart';

import '../sections/section.dart';

import 'cross_listing.dart';
import 'cross_listing_exception.dart';
import 'cross_listing_service.dart';

/// The [CrossListingModifierComponent] class...
@Component(
  selector: 'cross-listing-modifier',
  templateUrl: 'cross_listing_modifier_component.html',
  styleUrls: const ['cross_listing_modifier_component.css'],
  directives: const [
    ModalComponent, MaterialDialogComponent, MaterialCheckboxComponent,
    MaterialButtonComponent, MaterialIconComponent, NgFor, NgIf
  ],
  providers: const [
    CourseRequestService, CrossListingService, WorkflowService,
    overlayBindings
  ]
)
class CrossListingModifierComponent implements OnInit {
  bool isVisible;

  @Input()
  CrossListing crossListing;

  List<Section> requestedSections;

  List<Section> _selectedSections;

  final CourseRequestService _courseRequestService;

  final CrossListingService _crossListingService;

  final WorkflowService _workflowService;

  /// The [CrossListingModifierComponent] constructor...
  CrossListingModifierComponent (
    this._courseRequestService, this._crossListingService, this._workflowService
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

  /// The [sectionInCrossListing] method...
  bool sectionInCrossListing (Section section) =>
    sectionHasCrossListing (section) && crossListing.contains (section);

  /// The [sectionInOtherCrossListing] method...
  bool sectionInOtherCrossListing (Section section) =>
    sectionHasCrossListing (section) && !crossListing.contains (section);

  /// The [handleCrossListingSection] method...
  void handleCrossListingSection (Section section, dynamic checked) {
    if ('true' == checked) {
      if (!_selectedSections.contains (section)) {
        _selectedSections.add (section);
      }
    } else {
      _selectedSections.remove (section);
    }
  }

  /// The [modifyCrossListingSet] method...
  void modifyCrossListingSet() {
    try {
      if (1 == _selectedSections.length) {
        throw new CrossListingException (
          'Cannot confirm a cross-listing set with only one section.'
        );
      }

      _selectedSections.forEach ((Section section) {
        _crossListingService.addSectionToCrossListing (section, crossListing);
      });

      _handleRemovedSections();
      _crossListingService.confirmCrossListings();
      _checkCrossListingConditions();
    } catch (_) {}

    isVisible = false;
  }

  /// The [_handleRemovedSections] method...
  void _handleRemovedSections() {
    List<Section> removedSections = crossListing.sections.where (
      (Section section) => !_selectedSections.contains (section)
    );

    removedSections.forEach ((Section section) {
      _crossListingService.removeSectionFromCrossListing (section, crossListing);
    });
  }

  /// The [_checkCrossListingConditions] method...
  void _checkCrossListingConditions() {
    if (_crossListingService.verifyCrossListings()) {
      _workflowService.markCrossListingsHandled();
    } else {
      _workflowService.markPreventWorkflowProgress();
    }
  }
}
