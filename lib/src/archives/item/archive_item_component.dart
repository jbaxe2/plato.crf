library plato.crf.components.archive.item;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../_application/progress/progress_service.dart';

import '../browse_archive_service.dart';

import 'archive_item.dart';

/// The [ArchiveItemComponent] class...
@Component(
  selector: 'archive-item',
  templateUrl: 'archive_item_component.html',
  styleUrls: const ['archive_item_component.css'],
  directives: const [NgIf],
  providers: const [BrowseArchiveService, ProgressService]
)
class ArchiveItemComponent implements OnInit, RendersValue<ArchiveItem> {
  @override
  ArchiveItem value;

  bool showPreviewLink;

  final BrowseArchiveService _browseArchiveService;

  final ProgressService _progressService;

  /// The [ArchiveItemComponent] constructor...
  ArchiveItemComponent (this._browseArchiveService, this._progressService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    showPreviewLink = value.items.isEmpty && !value.title.startsWith ('-----');
  }

  /// The [previewResource] method...
  Future previewResource() async {
    _progressService.invoke ('Loading the resource (${value.title}).');

    try {
      await _browseArchiveService.previewResource (value);
    } catch (_) {}

    _progressService.revoke();
  }
}
