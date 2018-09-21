library plato.crf.components.previous_content.selection;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/progress/progress_service.dart';

import '../archives/retrieve_archives_service.dart';
import '../archives/pull_archive_service.dart';
import '../archives/browse_archive_service.dart';

import '../enrollments/enrollment.dart';
import '../enrollments/enrollments_service.dart';

import '../sections/section.dart';

import 'previous_content_mapping.dart';
import 'previous_content_service.dart';

/// The [PreviousContentSelectionComponent] class...
@Component(
  selector: 'previous-content-selection',
  templateUrl: 'previous_content_selection_component.html',
  styleUrls: const ['previous_content_selection_component.css'],
  directives: const [
    ModalComponent, MaterialDialogComponent, MaterialIconComponent,
    MaterialRadioGroupComponent, MaterialRadioComponent, MaterialButtonComponent,
    NgIf, NgFor, NgModel
  ],
  providers: const [
    PreviousContentService, EnrollmentsService, RetrieveArchivesService,
    PullArchiveService, BrowseArchiveService, ProgressService
  ]
)
class PreviousContentSelectionComponent implements OnInit {
  List<Enrollment> enrollments;

  Section invokerSection;

  bool isVisible;

  Enrollment selected;

  static bool _checkedForArchives = false;

  final PreviousContentService _previousContentService;

  final EnrollmentsService _enrollmentsService;

  final RetrieveArchivesService _retrieveArchivesService;

  final PullArchiveService _pullArchiveService;

  final BrowseArchiveService _browseArchiveService;

  final ProgressService _progressService;

  /// The [PreviousContentSelectionComponent] constructor...
  PreviousContentSelectionComponent (
    this._previousContentService, this._enrollmentsService, this._retrieveArchivesService,
    this._browseArchiveService, this._pullArchiveService, this._progressService
  );

  /// The [ngOnInit] method...
  @override
  Future<void> ngOnInit() async {
    enrollments = _enrollmentsService.enrollments;
    isVisible = false;

    _previousContentService.sectionsStreamer.stream.listen (
      (Section section) {
        invokerSection = section;
        isVisible = true;
      }
    );

    _retrieveArchivesService.archiveStreamController.stream.listen (
      (Enrollment archiveEnrollment) => enrollments.add (archiveEnrollment)
    );

    if (!_checkedForArchives) {
      await _retrieveArchiveEnrollments();
    }
  }

  /// The [browseArchive] method...
  Future<void> browseArchive (String archiveId) async {
    try {
      String termId = (archiveId.split ('_')).last;

      _progressService.invoke ('Pulling the archive for browsing.');
      await _pullArchiveService.pullArchive (archiveId, termId);

      _progressService.invoke ('Processing course archive information.');
      await _browseArchiveService.browseArchive (archiveId);
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [confirmPreviousContent] method...
  void confirmPreviousContent() {
    PreviousContentMapping previousContent;

    try {
      previousContent =
        _previousContentService.previousContents.firstWhere (
          (PreviousContentMapping prevContent) => (prevContent.section == invokerSection)
        );
    } catch (_) {}

    try {
      if (null == previousContent) {
        _previousContentService.createPreviousContent (invokerSection, selected);
      } else {
        _previousContentService.setPreviousContentEnrollment (
          previousContent, selected
        );
      }

      _previousContentService.confirmPreviousContents();
    } catch (_) {}

    isVisible = false;
  }

  /// The [_retrieveArchiveEnrollments] method...
  Future<void> _retrieveArchiveEnrollments() async {
    _progressService.invoke ('Determining if there are any archived enrollments.');

    try {
      await _retrieveArchivesService.retrieveArchives();
      _checkedForArchives = true;
    } catch (_) {}

    _progressService.revoke();
  }
}
