library plato.angular.components.archive.resource;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'archive_resource.dart';
import 'archives_service.dart';

/// The [ResourceComponent] class...
@Component(
  selector: 'archive-resource',
  templateUrl: 'resource_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, ArchivesService]
)
class ResourceComponent implements OnInit {
  ArchiveResource resource;

  bool isVisible;

  final ArchivesService _archiveService;

  /// The [ResourceComponent] constructor...
  ResourceComponent (this._archiveService);

  /// The [ngOnInit] method...
  void ngOnInit() {
    isVisible = false;

    _archiveService.resourceController.stream.listen ((ArchiveResource aResource) {
      resource = aResource;
      isVisible = true;
    });
  }
}
