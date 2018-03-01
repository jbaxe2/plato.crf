library plato.angular.services.banner.sections;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart';

import 'section.dart';

const String _SECTIONS_URI = '/plato/retrieve/sections';

/// The [SectionsService] class...
@Injectable()
class SectionsService {
  List<Section> sections;

  final Client _http;

  /// The [SectionsService] constructor...
  SectionsService (this._http) {
    sections = new List<Section>();
  }

  /// The [retrieveCourses] method...
  Future<List<Section>> retrieveCourses (String courseId, String termId) async {
    try {
      final Response sectionsResponse = await _http.get (
        '$_SECTIONS_URI?courseId=$courseId&termId=$termId'
      );

      List<Map<String, String>> rawSections =
        (JSON.decode (sectionsResponse.body) as Map)['sections'];

      rawSections.forEach ((Map<String, String> rawSection) {
        sections.add (
          new Section (
            null, null, '', '', '', ''
          )
        );
      });
    } catch (_) {
      print (_.toString());
    }

    return sections;
  }
}
