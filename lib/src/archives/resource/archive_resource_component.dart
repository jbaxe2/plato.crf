library plato.angular.components.archive.resource;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../browse_archive_service.dart';

import 'archive_resource.dart';

/// The [ArchiveResourceComponent] class...
@Component(
  selector: 'archive-resource',
  templateUrl: 'archive_resource_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, BrowseArchiveService]
)
class ArchiveResourceComponent implements OnInit {
  ArchiveResource resource;

  bool isVisible;

  final BrowseArchiveService _browseArchiveService;

  /// The [ArchiveResourceComponent] constructor...
  ArchiveResourceComponent (this._browseArchiveService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    isVisible = false;

    _browseArchiveService.resourceController.stream.listen (
      (ArchiveResource aResource) {
        resource = aResource;
        isVisible = true;
      }
    );
  }
}
