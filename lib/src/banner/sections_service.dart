library plato.angular.services.banner.sections;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import 'package:plato_angular/src/banner/banner_exception.dart';

import 'section.dart';

const String _SECTIONS_URI = '/plato/retrieve/sections';

/// The [SectionsService] class...
@Injectable()
class SectionsService {
  String _courseId;

  String _termId;

  List<Section> sections;

  final Client _http;

  static SectionsService _instance;

  /// The [SectionsService] factory constructor...
  factory SectionsService (Client http) =>
    _instance ?? (_instance = new SectionsService._ (http));

  /// The [SectionsService] private constructor...
  SectionsService._ (this._http) {
    sections = new List<Section>();
  }

  /// The [setCourseId] method...
  Future setCourseId (String courseId) async {
    _courseId = courseId;

    if (null != _termId) {
      retrieveSections();
    }
  }

  /// The [setTermId] method...
  Future setTermId (String termId) async {
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

      sections.clear();

      rawSections.forEach ((Map<String, String> rawSection) {
        sections.add (
          new Section (
            rawSection['_id'], rawSection['term'], rawSection['crsno'],
            rawSection['title'], rawSection['facname'], rawSection['mplace'],
            rawSection['mtime']
          )
        );
      });
    } catch (_) {
      throw new BannerException (
        'Retrieving the sections information resulted in an error.'
      );
    }
  }
}
