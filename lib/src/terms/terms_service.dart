library plato.crf.services.terms;

import 'dart:async' show Future;
import 'dart:convert' show json, utf8;

import 'package:http/http.dart' show Client;

import 'term.dart';
import 'term_exception.dart';
import 'term_factory.dart';

const String _TERMS_URI = '/plato/retrieve/terms';

/// The [TermsService] class...
class TermsService {
  List<Term> terms;

  final TermFactory _termFactory = TermFactory();

  final Client _http;

  static TermsService _instance;

  /// The [TermsService] factory constructor...
  factory TermsService (Client http) =>
    _instance ?? (_instance = TermsService._ (http));

  /// The [TermsService] private constructor...
  TermsService._ (this._http) {
    terms = <Term>[];
  }

  /// The [retrieveTerms] method...
  Future<void> retrieveTerms() async {
    try {
      final termsResponse = await _http.get (_TERMS_URI);

      List rawTerms =
        (json.decode (utf8.decode (termsResponse.bodyBytes)) as Map)['terms'];

      terms
        ..clear()
        ..addAll (_termFactory.createAll (rawTerms.cast()));
    } catch (_) {
      throw TermException ('Unable to retrieve the list of terms.');
    }
  }
}
