library plato.angular.components.previous_content;

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

/// The [PreviousContentComponent] class...
@Component(
  selector: 'previous-content',
  templateUrl: 'previous_content_component.html',
  styleUrls: const ['previous_content_component.css'],
  directives: const [coreDirectives, materialDirectives],
  providers: const [
    PreviousContentService, EnrollmentsService, RetrieveArchivesService,
    PullArchiveService, BrowseArchiveService, ProgressService
  ]
)
class PreviousContentComponent implements OnInit {
  List<Enrollment> enrollments;

  Section invokerSection;

  bool isVisible;

  Enrollment selected;

  final PreviousContentService _previousContentService;

  final EnrollmentsService _enrollmentsService;

  final RetrieveArchivesService _retrieveArchivesService;

  final PullArchiveService _pullArchiveService;

  final BrowseArchiveService _browseArchiveService;

  final ProgressService _progressService;

  /// The [PreviousContentComponent] constructor...
  PreviousContentComponent (
    this._previousContentService, this._enrollmentsService, this._retrieveArchivesService,
    this._browseArchiveService, this._pullArchiveService, this._progressService
  );

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
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
  }

  /// The [browseArchive] method...
  Future browseArchive (String archiveId) async {
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
}
