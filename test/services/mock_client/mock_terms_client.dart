library plato.angular.tests.mock.client.terms;

import 'dart:async' show Future;
import 'dart:convert' show JSON;

import 'abstract_mock_client.dart';
import 'mock_response.dart';

/// The [MockTermsClient] class...
class MockTermsClient implements AbstractMockClient {
  /// The [MockTermsClient] default constructor...
  MockTermsClient();

  /// The [get] method...
  @override
  Future<Response> get (String mockUri) async {
    return new Response()
      ..body = _mockTerms();
  }

  /// The [_mockTerms] method...
  String _mockTerms() {
    return '{"terms":[{"id":"2018spring_pp","description":"Spring 2018 (PP)"},'
      '{"id":"2018spring","description":"Spring 2018"},{"id":"2018summer1",'
      '"description":"Summer I 2018"},{"id":"2018summer2","description":"Summer'
      'II 2018"},{"id":"2018fall","description":"Fall 2018"}]}';
  }
}
