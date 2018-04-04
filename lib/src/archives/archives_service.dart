library plato.angular.services.archives;

import 'dart:async' show Future, StreamController;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import '../enrollments/enrollment.dart';
import '../enrollments/enrollment_factory.dart';

import './course/archive_course.dart';
import './course/archive_course_factory.dart';

import './resource/archive_resource.dart';

import 'archive_exception.dart';

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

  EnrollmentFactory _enrollmentFactory;

  ArchiveCourseFactory _archiveCourseFactory;

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

    _enrollmentFactory = new EnrollmentFactory();
    _archiveCourseFactory = new ArchiveCourseFactory();
  }

  /// The [retrieveArchives] method...
  Future retrieveArchives() async {
    try {
      final Response archivesResponse = await _http.get (_RETRIEVE_URI);

      List<Map<String, String>> rawArchives =
        (JSON.decode (archivesResponse.body))['archives'];

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
        archiveCourseController.add (_archiveCourseFactory.create (rawArchiveInfo));
      } else if (rawArchiveInfo.containsKey ('resource')) {
        resourceController.add (
          _createResource (resourceId, resourceTitle, rawArchiveInfo['resource'])
        );
      } else {
        // Must have either a manifest outline or resource.
        throw rawArchiveInfo;
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

  /// The [_createResource] method...
  ArchiveResource _createResource (String resourceId, String title, String content) {
    if ('' == content) {
      content = '(The content for this resource returned blank.)';
    }

    return new ArchiveResource (resourceId, title, content);
  }
}
