library plato.angular.services.archives;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import '../enrollments/enrollment.dart';

import 'archive_course.dart';
import 'archive_exception.dart';
import 'archive_item.dart';
import 'archive_item_node.dart';
import 'archive_resource.dart';

const String _RETRIEVE_URI = '/plato/retrieve/archives';
const String _PULL_URI = '/plato/pull/archive';
const String _BROWSE_URI = '/plato/browse/archive';

/// The [ArchivesService] class...
@Injectable()
class ArchivesService {
  List<Enrollment> archiveEnrollments;

  StreamController<Enrollment> archiveStreamController;

  StreamController<ArchiveCourse> archiveCourseController;

  StreamController<ArchiveResource> resourceController;

  String _lastArchiveId;

  final Client _http;

  static ArchivesService _instance;

  /// The [ArchivesService] factory constructor...
  factory ArchivesService (Client http) =>
    _instance ?? (_instance = new ArchivesService._ (http));

  /// The [ArchivesService] private constructor...
  ArchivesService._ (this._http) {
    archiveEnrollments = new List<Enrollment>();

    archiveStreamController = new StreamController<Enrollment>.broadcast();
    archiveCourseController = new StreamController<ArchiveCourse>.broadcast();
    resourceController = new StreamController<ArchiveResource>.broadcast();
  }

  /// The [retrieveArchives] method...
  Future retrieveArchives() async {
    try {
      final Response archivesResponse = await _http.get (_RETRIEVE_URI);

      List<Map<String, String>> rawArchives =
        (JSON.decode (archivesResponse.body))['archives'];

      archiveEnrollments.clear();

      rawArchives.forEach ((Map<String, String> rawArchive) {
        var archiveEnrollment = new Enrollment (
          rawArchive['learn.user.username'],
          rawArchive['learn.course.id'],
          rawArchive['learn.course.name'],
          rawArchive['learn.membership.role'],
          rawArchive['learn.membership.available'],
          isArchive: true
        );

        archiveEnrollments.add (archiveEnrollment);
        archiveStreamController.add (archiveEnrollment);
      });

      archiveEnrollments.sort();
    } catch (_) {
      throw new ArchiveException (
        'Unable to retrieve the list of archived course enrollments.'
      );
    }
  }

  /// The [pullArchive] method...
  Future pullArchive (String archiveId, String termId) async {
    try {
      final Response archiveResponse = await _http.get (
        '$_PULL_URI?archiveId=$archiveId&archiveTerm=$termId'
      );

      String pulledArchive = JSON.decode (archiveResponse.body)['pulled'];

      if (pulledArchive != archiveId) {
        throw pulledArchive;
      }

      _lastArchiveId = archiveId;
    } catch (_) {
      throw new ArchiveException (
        'Unable to pull the specified archive.'
      );
    }
  }

  /// The [browseArchive] method...
  Future browseArchive (
    String archiveId, [String resourceId = 'none', String resourceTitle = 'N/A']
  ) async {
    try {
      final Response archiveResponse = await _http.get (
        '$_BROWSE_URI?archiveId=$archiveId&resourceId=$resourceId'
      );

      Map<String, dynamic> rawArchiveInfo = JSON.decode (archiveResponse.body);

      if (!(rawArchiveInfo.containsKey ('courseId') &&
            rawArchiveInfo.containsKey ('courseTitle'))) {
        throw rawArchiveInfo;
      }

      if (rawArchiveInfo.containsKey ('manifestOutline')) {
        var archiveCourse = new ArchiveCourse (
          rawArchiveInfo['courseId'], rawArchiveInfo['courseTitle'],
          _buildArchiveItems (rawArchiveInfo['manifestOutline'])
        );

        archiveCourseController.add (archiveCourse);
      }

      if (rawArchiveInfo.containsKey ('resource')) {
        resourceController.add (
          _createResource (resourceId, resourceTitle, rawArchiveInfo['resource'])
        );
      }
    } catch (_) {
      throw new ArchiveException (
        'Missing course information from retrieved archive information.'
      );
    }
  }

  /// The [previewResource] method...
  Future previewResource (String resourceId, String title) async =>
    await browseArchive (_lastArchiveId, resourceId, title);

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
          rawArchiveItem.forEach ((String subKey, dynamic subItems) {
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
        new ArchiveItemNode (resourceId, title)
          ..items = subArchiveItems
      );
    });

    return archiveItems;
  }

  /// The [_createResource] method...
  ArchiveResource _createResource (String resourceId, String title, String content) {
    return new ArchiveResource (resourceId, title, content);
  }
}
