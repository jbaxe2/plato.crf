@TestOn('browser')
library plato.angular.tests.services.terms;

import 'package:test/test.dart';

import 'package:plato_crf/src/terms/terms_service.dart';

import 'mock_client/mock_terms_client.dart';

var _http = new MockTermsClient();

/// The [main] function...
void main() {
  group (
    'Terms service:',
    () {
      testTwoTermsServiceReferencesAreSame();
      testRetrieveTerms();
    }
  );
}

/// The [testTwoTermsServiceReferencesAreSame] function...
void testTwoTermsServiceReferencesAreSame() {
  test (
    'Confirm that two terms service instance references are the same object.',
    () {
      var termsService1 = new TermsService (_http);
      var termsService2 = new TermsService (_http);

      expect ((identical (termsService1, termsService2)), true);
    }
  );
}

/// The [testRetrieveTerms] function...
void testRetrieveTerms() {
  test (
    'Retrieve the list of terms from the server.', () async {
      var termsService = new TermsService (_http);
      await termsService.retrieveTerms();

      expect ((0 < termsService.terms.length), true);
    }
  );
}
