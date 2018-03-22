library plato.angular.components.archive;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'archives_service.dart';

/// The [ArchiveComponent] class...
@Component(
  selector: 'archive',
  templateUrl: 'archive_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, ArchivesService]
)
class ArchiveComponent {
  final ArchivesService _archivesService;

  /// The [ArchiveComponent] constructor...
  ArchiveComponent (this._archivesService);
}
