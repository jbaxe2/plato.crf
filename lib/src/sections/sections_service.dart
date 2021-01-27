library plato.crf.services.sections;

import 'dart:async' show Future;
import 'dart:convert' show json, utf8;

import 'package:http/http.dart' show Client;

import 'section.dart';
import 'section_exception.dart';
import 'section_factory.dart';

const String _SECTIONS_URI = '/plato/retrieve/sections';

/// The [SectionsService] class...
class SectionsService {
  String _courseId;

  String _termId;

  List<Section> sections;

  SectionFactory _sectionFactory;

  final Client _http;

  static SectionsService _instance;

  /// The [SectionsService] factory constructor...
  factory SectionsService (Client http) =>
    _instance ?? (_instance = SectionsService._ (http));

  /// The [SectionsService] private constructor...
  SectionsService._ (this._http) {
    sections = <Section>[];
    _sectionFactory = SectionFactory();
  }

  /// The [setCourseId] method...
  Future<void> setCourseId (String courseId) async {
    if (courseId == _courseId) {
      return;
    }

    _courseId = courseId;

    if (null != _termId) {
      await _retrieveSections();
    }
  }

  /// The [setTermId] method...
  Future<void> setTermId (String termId) async {
    if (termId == _termId) {
      return;
    }

    _termId = termId;

    if (null != _courseId) {
      await _retrieveSections();
    }
  }

  /// The [_retrieveSections] method...
  Future<void> _retrieveSections() async {
    try {
      final sectionsResponse = await _http.get (
        '$_SECTIONS_URI?course=$_courseId&term=$_termId'
      );

      List rawSections =
        (json.decode (utf8.decode (sectionsResponse.bodyBytes)) as Map)['sections'];

      sections
        ..clear()
        ..addAll (_sectionFactory.createAll (rawSections.cast()))
        ..sort();
    } catch (_) {
      throw SectionException (
        'Retrieving the sections information resulted in an error.'
      );
    }
  }
}
