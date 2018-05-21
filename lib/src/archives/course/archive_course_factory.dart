library plato.crf.factory.archive.course;

import '../../_application/factory/plato_factory.dart';

import '../item/archive_item.dart';
import '../item/archive_item_node.dart';

import '../archive_exception.dart';

import 'archive_course.dart';

/// The [ArchiveCourseFactory] class...
class ArchiveCourseFactory implements PlatoFactory<ArchiveCourse> {
  String _lastArchiveId;

  /// The [ArchiveCourseFactory] default constructor...
  ArchiveCourseFactory();

  /// The [create] method...
  @override
  ArchiveCourse create (Map<String, dynamic> rawArchiveCourse) {
    if (!(rawArchiveCourse.containsKey ('courseId') &&
          rawArchiveCourse.containsKey ('courseTitle') &&
          rawArchiveCourse.containsKey ('manifestOutline'))) {
      throw new ArchiveException (
        'The provided archive course information was not properly formatted.'
      );
    }

    _lastArchiveId = rawArchiveCourse['courseId'];

    return new ArchiveCourse (
      rawArchiveCourse['courseId'], rawArchiveCourse['courseTitle'],
      _buildArchiveItems (rawArchiveCourse['manifestOutline'])
    );
  }

  /// The [createAll] method...
  @override
  List<ArchiveCourse> createAll (Iterable<Map<String, dynamic>> rawArchiveCourses) {
    var archiveCourses = new List<ArchiveCourse>();

    rawArchiveCourses.forEach ((Map<String, dynamic> rawArchiveCourse) {
      archiveCourses.add (create (rawArchiveCourse));
    });

    return archiveCourses;
  }

  /// The [_buildArchiveItems] method...
  List<ArchiveItem> _buildArchiveItems (Map<String, dynamic> rawArchiveItems) {
    var archiveItems = new List<ArchiveItemNode>();

    rawArchiveItems.forEach ((String itemKey, dynamic rawArchiveItem) {
      String resourceId = itemKey;
      String title = '';

      var subArchiveItems = new List<ArchiveItem>();

      if (rawArchiveItem is String) {
        title = rawArchiveItem;
      } else if (rawArchiveItem is Map) {
        title = rawArchiveItem[itemKey];

        if (1 < rawArchiveItem.keys.length) {
          rawArchiveItem.forEach ((dynamic subKey, dynamic subItems) {
            if (subItems is Map) {
              subArchiveItems.addAll (_buildArchiveItems (subItems));
            }
          });
        }
      }

      if (title.startsWith ('divider_')) {
        title = '-----------------------';
      }

      archiveItems.add (
        new ArchiveItemNode (_lastArchiveId, resourceId, title)
          ..items = subArchiveItems
      );
    });

    return archiveItems;
  }
}
