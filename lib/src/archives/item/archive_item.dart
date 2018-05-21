library plato.crf.models.archive.item;

/// The [ArchiveItem] class...
class ArchiveItem {
  final String archiveId;

  final String resourceId;

  final String title;

  List<ArchiveItem> items;

  /// The [ArchiveItem] constructor...
  ArchiveItem (this.archiveId, this.resourceId, this.title) {
    items = new List<ArchiveItem>();
  }
}
