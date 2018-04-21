library plato.angular.services.terms;

import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:angular/core.dart';

import 'package:http/http.dart' show Client, Response;

import 'term.dart';
import 'term_exception.dart';
import 'term_factory.dart';

const String _TERMS_URI = '/plato/retrieve/terms';

/// The [TermsService] class...
@Injectable()
class TermsService {
  List<Term> terms;

  TermFactory _termFactory;

  final Client _http;

  static TermsService _instance;

  /// The [TermsService] factory constructor...
  factory TermsService (Client http) =>
    _instance ?? (_instance = new TermsService._ (http));

  /// The [TermsService] private constructor...
  TermsService._ (this._http) {
    terms = new List<Term>();
    _termFactory = new TermFactory();
  }

  /// The [retrieveTerms] method...
  Future retrieveTerms() async {
    try {
      final Response termsResponse = await _http.get (_TERMS_URI);

      List<Map<String, String>> rawTerms =
        (json.decode (termsResponse.body) as Map)['terms'];

      terms
        ..clear()
        ..addAll (_termFactory.createAll (rawTerms));
    } catch (_) {
      throw new TermException ('Unable to retrieve the list of terms.');
    }
  }
}
