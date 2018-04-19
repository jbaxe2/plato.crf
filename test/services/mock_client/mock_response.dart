library plato.angular.tests.mock.response;

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

export 'package:http/http.dart' show Response;

/// The [MockResponse] mock class...
class MockResponse extends Mock implements Response {
  String body;

  /// The [MockResponse] default constructor...
  MockResponse();
}