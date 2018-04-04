library plato.angular.models.archive.item.node;

import 'package:angular_components/angular_components.dart';

import 'archive_item.dart';

/// The [ArchiveItemNode] class...
class ArchiveItemNode extends ArchiveItem with MaterialTreeExpandState {
  /// The [ArchiveItemNode] constructor...
  ArchiveItemNode (String resourceId, String title) : super (resourceId, title);
}
