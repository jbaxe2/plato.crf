library plato.crf.components.cross_listing;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/workflow/workflow_service.dart';

import '../sections/section.dart';

import 'cross_listing.dart';
import 'cross_listing_modifier_component.dart';
import 'cross_listing_service.dart';

/// The [CrossListingComponent] class...
@Component(
  selector: 'cross-listing',
  templateUrl: 'cross_listing_component.html',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'cross_listing_component.css'
  ],
  directives: [
    MaterialExpansionPanel, MaterialListComponent, MaterialListItemComponent,
    MaterialButtonComponent, MaterialIconComponent,
    MaterialInkTooltipComponent, MaterialTooltipDirective,
    MaterialTooltipSourceDirective, MaterialTooltipTargetDirective,
    CrossListingModifierComponent,
    NgIf, NgFor
  ],
  providers: [CrossListingService, WorkflowService]
)
class CrossListingComponent implements OnInit {
  @Input()
  CrossListing crossListing;

  List<Section> sections;

  @Input()
  Section invokerSection;

  @Input()
  int setNumber;

  @ViewChild('crossListingModifier')
  CrossListingModifierComponent crossListingModifier;

  bool get hasInvokerSection => crossListing.contains (invokerSection);

  final CrossListingService _crossListingService;

  final WorkflowService _workflowService;

  /// The [CrossListingComponent] constructor...
  CrossListingComponent (this._crossListingService, this._workflowService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    sections = crossListing.sections;

    _checkCrossListingConditions();
  }

  /// The [addSectionToCrossListing] method...
  void addSectionToCrossListing() {
    try {
      _crossListingService.addSectionToCrossListing (invokerSection, crossListing);
      _checkCrossListingConditions();
    } catch (_) {}
  }

  /// The [removeSectionFromCrossListing] method...
  void removeSectionFromCrossListing() {
    try {
      _crossListingService.removeSectionFromCrossListing (invokerSection, crossListing);
      _checkCrossListingConditions();
    } catch (_) {}
  }

  /// The [modifyCrossListingSections] method...
  void modifyCrossListingSections() {
    crossListingModifier.isVisible = true;
  }

  /// The [removeCrossListing] method...
  bool removeCrossListing() {
    try {
      _crossListingService.removeCrossListing (crossListing);
      _checkCrossListingConditions();
    } catch (_) {}

    return false;
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
