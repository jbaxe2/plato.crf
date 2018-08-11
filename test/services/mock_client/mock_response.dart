library plato.crf.tests.mock.response;

import 'dart:convert' show utf8;
import 'dart:typed_data' show Uint8List;

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

export 'package:http/http.dart' show Response;

/// The [MockResponse] mock class...
class MockResponse extends Mock implements Response {
  @override
  String body;

  @override
  Uint8List get bodyBytes => utf8.encode (body);

  /// The [MockResponse] default constructor...
  MockResponse();
}
