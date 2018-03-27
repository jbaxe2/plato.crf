library plato.angular.services.archives;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show JSON;
import 'dart:html' show window;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import '../enrollments/enrollment.dart';

import 'archive_exception.dart';
import 'archive_item.dart';

const String _RETRIEVE_URI = '/plato/retrieve/archives';
const String _PULL_URI = '/plato/pull/archive';
const String _BROWSE_URI = '/plato/browse/archive';

/// The [ArchivesService] class...
@Injectable()
class ArchivesService {
  List<Enrollment> archiveEnrollments;

  StreamController<Enrollment> archiveStreamController;

  StreamController<List<ArchiveItem>> archiveItemController;

  StreamController<String> resourceController;

  final Client _http;

  static ArchivesService _instance;

  /// The [ArchivesService] factory constructor...
  factory ArchivesService (Client http) =>
    _instance ?? (_instance = new ArchivesService._ (http));

  /// The [ArchivesService] private constructor...
  ArchivesService._ (this._http) {
    archiveEnrollments = new List<Enrollment>();

    archiveStreamController = new StreamController<Enrollment>.broadcast();
    archiveItemController = new StreamController<List<ArchiveItem>>.broadcast();
    resourceController = new StreamController<String>.broadcast();
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
    } catch (_) {
      throw new ArchiveException (
        'Unable to pull the specified archive.'
      );
    }
  }

  /// The [browseArchive] method...
  Future browseArchive (String archiveId, [String resourceId = 'none']) async {
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
        _parseManifestOutline (rawArchiveInfo['manifestOutline']);
      }

      if (rawArchiveInfo.containsKey ('resource')) {
        resourceController.add (rawArchiveInfo['resource']);
      }
    } catch (_) {
      throw new ArchiveException (
        'Missing course information from retrieved archive information.'
      );
    }
  }

  /// The [_parseManifestOutline] method...
  void _parseManifestOutline (Map<String, dynamic> manifestOutline) {
    List<ArchiveItem> manifestItems = _buildArchiveItem (manifestOutline);

    if (manifestItems.isNotEmpty) {
      archiveItemController.add (manifestItems);
    }
  }

  /// The [_buildArchiveItem] method...
  List<ArchiveItem> _buildArchiveItem (Map<String, Map> rawArchiveItems) {
    var archiveItems = new List<ArchiveItem>();

    rawArchiveItems.forEach ((String itemKey, Map rawArchiveItem) {
      String title = '';
      ArchiveItem archiveItem;
      List<ArchiveItem> subArchiveItems;

      window.console.debug (rawArchiveItem);

      if (rawArchiveItem[itemKey] is String) {
        if (rawArchiveItem[itemKey].contains ('divider')) {
          rawArchiveItem[itemKey] = '-------------------------';
        }

        title = rawArchiveItem[itemKey];
      } else if (rawArchiveItem[itemKey] is Map) {
        window.console.log ('found a sub archive item map');
        window.console.debug (rawArchiveItem[itemKey]);

        title = rawArchiveItem[itemKey].values.first;

        subArchiveItems = _buildArchiveItem (rawArchiveItem[itemKey]);
      } else {
        window.console.log ('raw archive type is ${rawArchiveItem[itemKey].runtimeType.toString()}');
      }

      archiveItem = new ArchiveItem (itemKey, title);

      if (null != subArchiveItems) {
        archiveItem.items = subArchiveItems;
      }

      archiveItems.add (archiveItem);
    });

    return archiveItems;
  }
}
