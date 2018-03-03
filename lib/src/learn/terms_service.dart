library plato.angular.services.banner.terms;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'package:angular/core.dart';

import 'package:http/http.dart';

import '../error/learn_exception.dart';

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

  /// The [retrieveTerms] method...
  Future retrieveTerms() async {
    try {
      final Response termsResponse = await _http.get (_TERMS_URI);

      List<Map<String, String>> rawTerms =
        (JSON.decode (termsResponse.body) as Map)['terms'];

      rawTerms.forEach ((Map<String, String> rawTerm) {
        terms.add (new Term (rawTerm['id'], rawTerm['description']));
      });
    } catch (_) {
      throw new LearnException ('Unable to retrieve the list of terms.');
    }
  }
}
