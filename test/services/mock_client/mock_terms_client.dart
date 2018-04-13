library plato.angular.tests.mock.client.terms;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'abstract_mock_client.dart';
import 'mock_response.dart';

/// The [MockTermsClient] class...
class MockTermsClient extends AbstractMockClient {
  /// The [MockTermsClient] default constructor...
  MockTermsClient();

  /// The [get] method...
  @override
  Future<Response> get (dynamic mockUri, {headers: const {}}) async {
    return new Future.value (
      new MockResponse()
        ..body = JSON.encode ({'terms': _mockTerms()})
    );
  }

  /// The [_mockTerms] method...
  List<Map<String, String>> _mockTerms() {
    return [
      {'id': '2018fall', 'description': 'Fall 2018'},
      {'id': '2018summer2', 'description': 'Summer II 2018'},
      {'id': '2018summer1', 'description': 'Summer I 2018'}
    ];
  }
}
