library plato.angular.services.archive.retrieve;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show json;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import '../enrollments/enrollment.dart';
import '../enrollments/enrollment_factory.dart';

import 'archive_exception.dart';

const String _RETRIEVE_URI = '/plato/retrieve/archives';

/// The [RetrieveArchivesService] class...
@Injectable()
class RetrieveArchivesService {
  List<Enrollment> archiveEnrollments;

  EnrollmentFactory _enrollmentFactory;

  StreamController<Enrollment> archiveStreamController;

  final Client _http;

  static RetrieveArchivesService _instance;

  /// The [RetrieveArchivesService] factory constructor...
  factory RetrieveArchivesService (Client http) =>
    _instance ?? (_instance = new RetrieveArchivesService._ (http));

  /// The [RetrieveArchivesService] named constructor...
  RetrieveArchivesService._ (this._http) {
    archiveEnrollments = new List<Enrollment>();
    _enrollmentFactory = new EnrollmentFactory();
    archiveStreamController = new StreamController<Enrollment>.broadcast();
  }

  /// The [retrieveArchives] method...
  Future retrieveArchives() async {
    try {
      final Response archivesResponse = await _http.get (_RETRIEVE_URI);

      List<Map<String, String>> rawArchives =
        (json.decode (archivesResponse.body))['archives'];

      archiveEnrollments
        ..clear()
        ..addAll (_enrollmentFactory.createAll (rawArchives, true))
        ..sort();

      archiveEnrollments.forEach (
        (Enrollment archiveEnrollment) =>
          archiveStreamController.add (archiveEnrollment)
      );
    } catch (_) {
      throw new ArchiveException (
          'Unable to retrieve the list of archived course enrollments.'
      );
    }
  }
}
