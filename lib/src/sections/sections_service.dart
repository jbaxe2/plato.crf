library plato.angular.services.sections;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import 'section.dart';
import 'section_exception.dart';
import 'section_factory.dart';

const String _SECTIONS_URI = '/plato/retrieve/sections';

/// The [SectionsService] class...
@Injectable()
class SectionsService {
  String _courseId;

  String _termId;

  List<Section> sections;

  SectionFactory _sectionFactory;

  final Client _http;

  static SectionsService _instance;

  /// The [SectionsService] factory constructor...
  factory SectionsService (Client http) =>
    _instance ?? (_instance = new SectionsService._ (http));

  /// The [SectionsService] private constructor...
  SectionsService._ (this._http) {
    sections = new List<Section>();
    _sectionFactory = new SectionFactory();
  }

  /// The [setCourseId] method...
  Future setCourseId (String courseId) async {
    if (courseId == _courseId) {
      return;
    }

    _courseId = courseId;

    if (null != _termId) {
      retrieveSections();
    }
  }

  /// The [setTermId] method...
  Future setTermId (String termId) async {
    if (termId == _termId) {
      return;
    }

    _termId = termId;

    if (null != _courseId) {
      retrieveSections();
    }
  }

  /// The [retrieveSections] method...
  Future retrieveSections() async {
    try {
      final Response sectionsResponse = await _http.get (
        '$_SECTIONS_URI?course=$_courseId&term=$_termId'
      );

      List<Map<String, String>> rawSections =
        (JSON.decode (sectionsResponse.body) as Map)['sections'];

      sections
        ..clear()
        ..addAll (_sectionFactory.createAll (rawSections))
        ..sort();
    } catch (_) {
      throw new SectionException (
        'Retrieving the sections information resulted in an error.'
      );
    }
  }
}
