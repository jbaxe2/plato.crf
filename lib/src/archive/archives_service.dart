library plato.angular.services.archives;

import 'dart:async' show Future;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client;

const String _PULL_URI = '/plato/pull/archive';
const String _RETRIEVE_URI = '/plato/retrieve/archives';
const String _CONTENT_URI = '/plato/retrieve/content';

/// The [ArchivesService] class...
@Injectable()
class ArchivesService {
  final Client _http;

  static ArchivesService _instance;

  /// The [ArchivesService] factory constructor...
  factory ArchivesService (Client http) =>
    _instance ?? (_instance = new ArchivesService._ (http));

  /// The [ArchivesService] private constructor...
  ArchivesService._ (this._http);

  /// The [retrieveArchives] method...
  Future retrieveArchives() async {}

  /// The [pullArchive] method...
  Future pullArchive (String archiveId, String termId) async {}

  /// The [retrieveContent] method...
  Future retrieveContent (String contentId) async {}
}
