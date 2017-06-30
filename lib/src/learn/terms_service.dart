library plato.angular.services.banner.terms;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular2/core.dart';

import 'package:http/http.dart';

import 'term.dart';

const String _TERMS_URI = '/plato/retrieve/terms';

/// The [TermsService] class...
@Injectable()
class TermsService {
  List<Term> terms;

  final Client _http;

  /// The [TermsService] constructor...
  TermsService (this._http) {
    terms = new List<Term>();
  }

  /// The [loadTerms] method...
  Future<List<Term>> loadTerms() async {
    try {
      final Response termsResponse = await _http.get (_TERMS_URI);

      List<Map<String, String>> rawTerms =
        (JSON.decode (termsResponse.body) as Map)['terms'];

      rawTerms.forEach ((Map<String, String> rawDept) {
        terms.add (new Term (rawDept['id'], rawDept['description']));
      });
    } catch (_) {}

    return terms;
  }
}
