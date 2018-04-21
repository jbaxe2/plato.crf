library plato.angular.tests.mock.client.courses;

import 'dart:async' show Future;
import 'dart:convert' show json;

import 'abstract_mock_client.dart';
import 'mock_response.dart';

/// The [MockCoursesClient] class...
class MockCoursesClient extends AbstractMockClient {
  /// The [MockCoursesClient] default constructor...
  MockCoursesClient();

  /// The [get] method...
  @override
  Future<Response> get (dynamic mockUri, {headers: const {}}) async {
    var mockResponse = new MockResponse();

    bool validMockUri =
      mockUri.toString().contains ('CAIS') && mockUri.toString().contains ('2018fall');

    mockResponse.body = json.encode ({'courses': (validMockUri ? _mockCourses() : [])});

    return new Future.value (mockResponse);
  }

  /// The [_mockCourses] method...
  List<Map<String, String>> _mockCourses() {
    return [
      {'courseId': 'CAIS0101', 'title': '[CAIS0101] COMPUTERS IN SOCIETY'},
      {'courseId': 'CAIS0117', 'title': '[CAIS0117] INTRO COMPUTER PROGRAMMING'},
      {'courseId': 'CAIS0351', 'title': '[CAIS0351] INTRO TO THEORY OF COMPUTATION'}
    ];
  }
}
