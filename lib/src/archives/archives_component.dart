library plato.angular.components.archive;

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'archive_item.dart';
import 'archives_service.dart';

/// The [ArchivesComponent] class...
@Component(
  selector: 'archives',
  templateUrl: 'archives_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, ArchivesService]
)
class ArchivesComponent implements OnInit {
  List<ArchiveItem> archiveItems;

  final ArchivesService _archivesService;

  /// The [ArchivesComponent] constructor...
  ArchivesComponent (this._archivesService);

  /// The [ngOnInit] method...
  void ngOnInit() {
    archiveItems = new List<ArchiveItem>();

    _archivesService.archiveItemController.stream.listen (
      (List<ArchiveItem> someArchiveItems) {
        window.console.debug (someArchiveItems);
      }
    );
  }
}
