library plato.angular.tests.mock.client;

import 'dart:async' show Future;

import 'mock_response.dart';

/// The [AbstractMockClient] abstract class...
abstract class AbstractMockClient {
  /// The [get] method...
  Future<Response> get (String mockUri);
}
