library plato.angular.components.archive;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/model/ui/has_factory.dart';

import '../../_application/progress/progress_service.dart';

import '../item/archive_item.dart';
import '../item/archive_item_component.dart';
import '../item/archive_item_node.dart';
import '../item/archive_item_options.dart';

// ignore: uri_has_not_been_generated
import '../item/archive_item_component.template.dart' as aic;

import '../browse_archive_service.dart';

import 'archive_course.dart';

@Injectable()
ComponentFactory<ArchiveItemComponent> getArchiveItemComponentFactory (
  ArchiveItem item
) => aic.ArchiveItemComponentNgFactory;

/// The [ArchiveCourseComponent] class...
@Component(
  selector: 'archive-course',
  templateUrl: 'archive_course_component.html',
  directives: const [coreDirectives, materialDirectives],
  providers: const [
    materialProviders, BrowseArchiveService,
    const FactoryProvider (
      ArchiveItem, getArchiveItemComponentFactory,
      deps: const [BrowseArchiveService, ProgressService]
    )
  ]
)
class ArchiveCourseComponent implements OnInit, AfterViewInit {
  bool isVisible;

  ArchiveCourse _archiveCourse;

  String courseId;

  String courseTitle;

  List<ArchiveItem> archiveItems;

  ArchiveItemOptions archiveOptions;

  final FactoryRenderer<ArchiveItemComponent, ArchiveItem> archiveRenderer =
    getArchiveItemComponentFactory;

  final BrowseArchiveService _browseArchiveService;

  /// The [ArchiveCourseComponent] constructor...
  ArchiveCourseComponent (this._browseArchiveService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    isVisible = false;
    archiveItems = new List<ArchiveItemNode>();
  }

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    _browseArchiveService.archiveCourseController.stream.listen (
      (ArchiveCourse archiveCourse) => _setUpTreeForArchive (archiveCourse)
    );
  }

  /// The [_setUpTreeForArchive] method...
  void _setUpTreeForArchive (ArchiveCourse archiveCourse) {
    _archiveCourse = archiveCourse;

    courseId = _archiveCourse.id;
    courseTitle = _archiveCourse.title;

    archiveItems
      ..clear()
      ..addAll (_createRootArchiveItem());

    archiveOptions = new ArchiveItemOptions ([new OptionGroup (archiveItems)]);

    isVisible = true;
  }

  /// The [_createRootArchiveItem] method...
  List<ArchiveItem> _createRootArchiveItem() {
    String title = '${_archiveCourse.title} (click to expand)';

    var rootArchiveItem = new ArchiveItem (
      _archiveCourse.id, _archiveCourse.id, title
    );

    rootArchiveItem.items.addAll (_archiveCourse.rootArchiveItems);

    return [rootArchiveItem];
  }
}
