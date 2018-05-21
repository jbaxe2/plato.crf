library plato.crf.models.archive.course;

import '../../courses/course.dart';

import '../item/archive_item.dart';

/// The [ArchiveCourse] class...
class ArchiveCourse extends Course {
  final List<ArchiveItem> rootArchiveItems;

  /// The [ArchiveCourse] constructor...
  ArchiveCourse (
    String courseId, String title, this.rootArchiveItems
  ) : super (courseId, title);
}
