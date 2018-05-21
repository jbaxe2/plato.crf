library plato.crf.services.archive.pull;

import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import 'archive_exception.dart';

const String _PULL_URI = '/plato/pull/archive';

/// The [PullArchiveService] class...
@Injectable()
class PullArchiveService {
  final Client _http;

  static PullArchiveService _instance;

  /// The [PullArchiveService] factory constructor...
  factory PullArchiveService (Client http) =>
    _instance ?? (_instance = new PullArchiveService._ (http));

  /// The [PullArchiveService] private constructor...
  PullArchiveService._ (this._http);

  /// The [pullArchive] method...
  Future pullArchive (String archiveId, String termId) async {
    try {
      final Response archiveResponse = await _http.get (
        '$_PULL_URI?archiveId=$archiveId&archiveTerm=$termId'
      );

      String pulledArchive = json.decode (archiveResponse.body)['pulled'];

      if (pulledArchive != archiveId) {
        throw pulledArchive;
      }
    } catch (_) {
      throw new ArchiveException (
        'Unable to pull the specified archive.'
      );
    }
  }
}
