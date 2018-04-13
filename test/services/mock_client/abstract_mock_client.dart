library plato.angular.tests.mock.client;

import 'package:http/browser_client.dart';
import 'package:mockito/mockito.dart';

/// The [AbstractMockClient] abstract class...
abstract class AbstractMockClient extends Mock implements BrowserClient {}
