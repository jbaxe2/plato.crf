library plato.angular.components.archive.item;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../_application/progress/progress_service.dart';

import 'archive_item.dart';
import 'archives_service.dart';

/// The [ArchiveItemComponent] class...
@Component(
  selector: 'archive-item',
  template: r'''
    <span>{{value.title}}</span> &nbsp;
    <span *ngIf="showPreviewLink" class="preview-link">
      [<a (click)="previewResource()">preview resource</a>]
    </span>
  ''',
  styleUrls: const ['archive_item_component.scss.css'],
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, ArchivesService, ProgressService]
)
class ArchiveItemComponent implements OnInit, RendersValue<ArchiveItem> {
  @override
  ArchiveItem value;

  bool showPreviewLink;

  final ArchivesService _archivesService;

  final ProgressService _progressService;

  /// The [ArchiveItemComponent] constructor...
  ArchiveItemComponent (this._archivesService, this._progressService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    showPreviewLink = value.items.isEmpty && !value.title.startsWith ('-----');
  }

  /// The [previewResource] method...
  Future previewResource() async {
    _progressService.invoke ('Loading the resource (${value.title}).');

    try {
      await _archivesService.previewResource (value.resourceId, value.title);
    } catch (_) {}

    _progressService.revoke();
  }
}
