library plato.crf.components.previous_content;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/workflow/workflow_service.dart';

import '../cross_listings/cross_listing.dart';
import '../cross_listings/cross_listing_pipe.dart';

import '../course_request/course_request_service.dart';
import '../sections/section.dart';

import 'previous_content_selection_component.dart';
import 'previous_content_service.dart';

/// The [PreviousContentComponent] class...
@Component(
  selector: 'previous-content',
  templateUrl: 'previous_content_component.html',
  styleUrls: ['previous_content_component.css'],
  directives: [
    MaterialButtonComponent, MaterialIconComponent,
    MaterialListComponent, MaterialListItemComponent,
    PreviousContentSelectionComponent,
    NgFor, NgIf
  ],
  providers: [
    CourseRequestService, PreviousContentService, WorkflowService
  ],
  pipes: [CrossListingPipe]
)
class PreviousContentComponent implements AfterViewInit {
  List<CrossListing> crossListings;

  List<Section> sections;

  final CourseRequestService _courseRequestService;

  final PreviousContentService _previousContentService;

  final WorkflowService _workflowService;

  /// The [PreviousContentComponent] constructor...
  PreviousContentComponent (
    this._courseRequestService, this._previousContentService, this._workflowService
  ) {
    crossListings = <CrossListing>[];
    sections = <Section>[];
  }

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    _workflowService.markPreviousContentHandled();

    if (crossListings.isEmpty) {
      crossListings = _courseRequestService.crossListings;
    }

    if (sections.isEmpty) {
      sections = _courseRequestService.requestedSections;
    }
  }

  /// The [sectionHasCrossListing] method...
  bool sectionHasCrossListing (Section section) =>
    _courseRequestService.sectionHasCrossListing (section);

  /// The [sectionHasPreviousContent] method...
  bool sectionHasPreviousContent (Section section) =>
    _courseRequestService.sectionHasPreviousContent (section);

  /// The [getPreviousContentIdForSection] method...
  String getPreviousContentIdForSection (Section section) =>
    _courseRequestService.previousContentIdForSection (section);

  /// The [selectPreviousContent] method...
  void selectPreviousContent (Section section) =>
    _previousContentService.invokeForSection (section);

  /// The [removePreviousContent] method...
  void removePreviousContent (Section section) {
    _previousContentService.removePreviousContent (
      _courseRequestService.getPreviousContentForSection (section)
    );
  }
}
