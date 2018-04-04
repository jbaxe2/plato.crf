library plato.angular.models.archive.item;

/// The [ArchiveItem] class...
class ArchiveItem {
  final String resourceId;

  final String title;

  List<ArchiveItem> items;

  /// The [ArchiveItem] constructor...
  ArchiveItem (this.resourceId, this.title) {
    items = new List<ArchiveItem>();
  }
}
