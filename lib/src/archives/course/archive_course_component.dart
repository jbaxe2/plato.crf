library plato.angular.components.archive;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../item/archive_item.dart';
import '../item/archive_item_component.dart';
import '../item/archive_item_options.dart';
import '../item/archive_item_node.dart';

import '../browse_archive_service.dart';

import 'archive_course.dart';

/// The [ArchiveCourseComponent] class...
@Component(
  selector: 'archive-course',
  templateUrl: 'archive_course_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, BrowseArchiveService]
)
class ArchiveCourseComponent implements OnInit {
  bool isVisible;

  ArchiveCourse _archiveCourse;

  String courseId;

  String courseTitle;

  List<ArchiveItem> archiveItems;

  ArchiveItemOptions archiveOptions;

  final ComponentRenderer archiveRenderer = (_) => ArchiveItemComponent;

  final BrowseArchiveService _browseArchiveService;

  /// The [ArchiveCourseComponent] constructor...
  ArchiveCourseComponent (this._browseArchiveService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    isVisible = false;
    archiveItems = new List<ArchiveItemNode>();

    _browseArchiveService.archiveCourseController.stream.listen (
      (ArchiveCourse archiveCourse) {
        _archiveCourse = archiveCourse;

        courseId = _archiveCourse.id;
        courseTitle = _archiveCourse.title;

        archiveItems
          ..clear()
          ..addAll (_archiveCourse.rootArchiveItems);

        archiveOptions = new ArchiveItemOptions ([new OptionGroup (archiveItems)]);

        isVisible = true;
      }
    );
  }
}
