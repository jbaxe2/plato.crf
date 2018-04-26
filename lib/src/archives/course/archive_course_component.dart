library plato.angular.components.archive;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/model/ui/has_factory.dart';

import '../item/archive_item.dart';
import '../item/archive_item_component.dart';
import '../item/archive_item_node.dart';
import '../item/archive_item_options.dart';

// ignore: uri_has_not_been_generated
import '../item/archive_item_component.template.dart' as aic;

import '../browse_archive_service.dart';

import 'archive_course.dart';

@Injectable()
ComponentFactory getArchiveItemComponentFactory() => aic.ArchiveItemComponentNgFactory;

/// The [ArchiveCourseComponent] class...
@Component(
  selector: 'archive-course',
  templateUrl: 'archive_course_component.html',
  directives: const [coreDirectives, materialDirectives],
  providers: const [
    materialProviders, BrowseArchiveService
  ]
)
class ArchiveCourseComponent implements OnInit {
  bool isVisible;

  ArchiveCourse _archiveCourse;

  String courseId;

  String courseTitle;

  List<ArchiveItem> archiveItems;

  ArchiveItemOptions archiveOptions;

  final FactoryRenderer archiveRenderer = aic.ArchiveItemComponentNgFactory;

  final BrowseArchiveService _browseArchiveService;

  /// The [ArchiveCourseComponent] constructor...
  ArchiveCourseComponent (this._browseArchiveService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    isVisible = false;
    archiveItems = new List<ArchiveItemNode>();

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
