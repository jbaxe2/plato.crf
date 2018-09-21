library plato.crf.factory.term;

import '../_application/factory/plato_factory.dart';

import 'term.dart';
import 'term_exception.dart';

/// The [TermFactory] class...
class TermFactory implements PlatoFactory<Term> {
  /// The [TermFactory] default constructor...
  TermFactory();

  /// The [create] method...
  @override
  Term create (covariant Map<String, dynamic> rawTerm) {
    if (!(rawTerm.containsKey ('id') &&
          rawTerm.containsKey ('description'))) {
      throw new TermException (
        'The provided term information was improperly formatted.'
      );
    }

    return new Term (rawTerm['id'], rawTerm['description']);
  }

  /// The [createAll] method...
  @override
  List<Term> createAll (covariant Iterable<Map<String, dynamic>> rawTerms) {
    var terms = new List<Term>();

    try {
      rawTerms.forEach (
        (Map<String, dynamic> rawTerm) => terms.add (create (rawTerm))
      );
    } catch (_) {
      rethrow;
    }

    return terms;
  }
}
