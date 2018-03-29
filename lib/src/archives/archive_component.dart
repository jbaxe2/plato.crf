library plato.angular.components.archive;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'archive_course.dart';
import 'archive_item.dart';
import 'archives_service.dart';

/// The [ArchivesComponent] class...
@Component(
  selector: 'archive-course',
  templateUrl: 'archive_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, ArchivesService]
)
class ArchivesComponent implements OnInit {
  bool isVisible;

  ArchiveCourse _archiveCourse;

  String courseId;

  String courseTitle;

  List<ArchiveItem> archiveItems;

  SelectionOptions<ArchiveItem> archiveOptions;

  final ArchivesService _archivesService;

  /// The [ArchivesComponent] constructor...
  ArchivesComponent (this._archivesService);

  /// The [ngOnInit] method...
  void ngOnInit() {
    isVisible = false;
    archiveItems = new List<ArchiveItem>();

    _archivesService.archiveCourseController.stream.listen (
      (ArchiveCourse archiveCourse) {
        _archiveCourse = archiveCourse;

        courseId = _archiveCourse.id;
        courseTitle = _archiveCourse.title;

        archiveItems.clear();
        archiveItems = _archiveCourse.rootArchiveItems;

        archiveOptions = new SelectionOptions<ArchiveItem>.fromList (archiveItems);

        isVisible = true;
      }
    );
  }
}
