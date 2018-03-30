library plato.angular.components.archive;

import 'dart:html' show window;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'archive_course.dart';
import 'archive_item.dart';
import 'archive_item_component.dart';
import 'archive_item_options.dart';
import 'archive_item_node.dart';
import 'archives_service.dart';

/// The [ArchiveComponent] class...
@Component(
  selector: 'archive-course',
  templateUrl: 'archive_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, ArchivesService]
)
class ArchiveComponent implements OnInit {
  bool isVisible;

  ArchiveCourse _archiveCourse;

  String courseId;

  String courseTitle;

  List<ArchiveItem> archiveItems;

  ArchiveItemOptions archiveOptions;

  final ComponentRenderer archiveRenderer = (_) => ArchiveItemComponent;

  final ArchivesService _archivesService;

  /// The [ArchiveComponent] constructor...
  ArchiveComponent (this._archivesService);

  /// The [ngOnInit] method...
  void ngOnInit() {
    isVisible = false;
    archiveItems = new List<ArchiveItemNode>();

    _archivesService.archiveCourseController.stream.listen (
      (ArchiveCourse archiveCourse) {
        _archiveCourse = archiveCourse;

        courseId = _archiveCourse.id;
        courseTitle = _archiveCourse.title;

        archiveItems.clear();
        archiveItems = _archiveCourse.rootArchiveItems;

        window.console.debug (archiveItems);
        archiveOptions = new ArchiveItemOptions ([new OptionGroup (archiveItems)]);

        isVisible = true;
      }
    );
  }
}
