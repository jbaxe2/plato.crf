library plato.angular.tests.mock.client.departments;

import 'dart:async' show Future;
import 'dart:convert' show json;

import 'abstract_mock_client.dart';
import 'mock_response.dart';

/// The [MockDepartmentsClient] class...
class MockDepartmentsClient extends AbstractMockClient {
  /// The [MockDepartmentsClient] default constructor...
  MockDepartmentsClient();

  /// The [get] method...
  @override
  Future<Response> get (dynamic mockUri, {headers: const {}}) async {
    return new Future.value (
      new MockResponse()
        ..body = json.encode ({'departments': _mockDepartments()})
    );
  }

  /// The [_mockDepartments] method...
  List<Map<String, String>> _mockDepartments() {
    return [
      {'code': "ACCT", 'description': "Accounting"},
      {'code': "ART", 'description': "Art"},
      {'code': "ASTR", 'description': "Astronomy"},
      {'code': "AVIA", 'description': "Aviation"},
      {'code': "BIOL", 'description': "Biology"},
      {'code': "CAIS", 'description': "Computer and Information Science"},
      {'code': "CHEM", 'description': "Chemistry"},
      {'code': "COMM", 'description': "Communication"},
      {'code': "CRJU", 'description': "Criminal Justice"},
      {'code': "ECON", 'description': "Economics"},
      {'code': "EDUC", 'description': "Education"},
      {'code': "MATH", 'description': "Mathematics"},
      {'code': "MGMT", 'description': "Business Management"}
    ];
  }
}
