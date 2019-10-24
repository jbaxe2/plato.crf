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
  styleUrls: ['cross_listing_modifier_component.css'],
  directives: [
    ModalComponent, MaterialDialogComponent, MaterialCheckboxComponent,
    MaterialButtonComponent, MaterialIconComponent,
    NgFor, NgIf
  ],
  providers: [
    CourseRequestService, CrossListingService, WorkflowService,
    overlayBindings
  ]
)
class CrossListingModifierComponent implements OnInit, AfterViewInit {
  bool isVisible;

  @Input()
  CrossListing crossListing;

  List<Section> requestedSections;

  List<Section> _selectedSections;

  List<Section> _deselectedSections;

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
    _deselectedSections = new List<Section>();
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (requestedSections = _courseRequestService.requestedSections);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    requestedSections.forEach ((Section requestedSection) {
      if (sectionInCrossListing (requestedSection) &&
          !_selectedSections.contains (requestedSection)) {
        _selectedSections.add (requestedSection);
      }
    });
  }

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
        _deselectedSections.remove (section);
      }
    } else {
      _selectedSections.remove (section);

      if (!_deselectedSections.contains (section)) {
        _deselectedSections.add (section);
      }
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

      _handleRemovedSections();

      _selectedSections.forEach ((Section section) {
        _crossListingService.addSectionToCrossListing (section, crossListing);
      });

      _crossListingService.confirmCrossListings();
      _checkCrossListingConditions();
    } catch (_) {}

    isVisible = false;
  }

  /// The [_handleRemovedSections] method...
  void _handleRemovedSections() {
    _deselectedSections.forEach ((Section section) {
      try {
        _crossListingService.removeSectionFromCrossListing (section, crossListing);
      } catch (_) {}
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
