@TestOn('browser')
library plato.crf.tests.services.terms;

import 'package:test/test.dart';

import 'package:plato_crf/src/terms/terms_service.dart';

import '../testable.dart';

import 'mock_client/mock_terms_client.dart';

var _http = new MockTermsClient();

/// The [TermsServiceTester] class...
class TermsServiceTester implements Testable {
  /// The [TermsServiceTester] constructor...
  TermsServiceTester();

  /// The [run] method...
  void run() {
    group (
      'Terms service:',
      () {
        _testTwoTermsServiceReferencesAreSame();
        _testRetrieveTerms();
      }
    );
  }

  /// The [_testTwoTermsServiceReferencesAreSame] method...
  void _testTwoTermsServiceReferencesAreSame() {
    test (
      'Confirm that two terms service instance references are the same object.',
      () {
        var termsService1 = new TermsService (_http);
        var termsService2 = new TermsService (_http);

        expect ((identical (termsService1, termsService2)), true);
      }
    );
  }

  /// The [_testRetrieveTerms] method...
  void _testRetrieveTerms() {
    test (
      'Retrieve the list of terms from the server.',
      () async {
        var termsService = new TermsService (_http);
        await termsService.retrieveTerms();

        expect ((0 < termsService.terms.length), true);
      }
    );
  }
}
