library plato.angular.models.archive.item.options;

import 'package:angular_components/angular_components.dart';

import 'archive_item.dart';

/// The [ArchiveItemNode] class...
class ArchiveItemNode extends ArchiveItem with MaterialTreeExpandState {
  /// The [ArchiveItemNode] constructor...
  ArchiveItemNode (String resourceId, String title) : super (resourceId, title);
}

/// The [ArchiveItemOptions] class...
class ArchiveItemOptions extends SelectionOptions<ArchiveItemNode>
    implements Parent<ArchiveItemNode, List<OptionGroup<ArchiveItemNode>>> {
  ArchiveItemOptions (List<OptionGroup<ArchiveItemNode>> options) : super (options);

  /// The [hasChildren] method...
  @override
  bool hasChildren (ArchiveItemNode item) => item.items.isNotEmpty;

  /// The [childrenOf] method...
  @override
  DisposableFuture<List<OptionGroup<ArchiveItemNode>>> childrenOf (parentItem, [_]) =>
    new DisposableFuture.fromValue ([new OptionGroup (parentItem.items)]);
}
