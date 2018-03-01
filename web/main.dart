library plato.angular;

import 'package:angular/angular.dart';

import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'package:plato_angular/course_request.dart';

/// The [main] function...
void main() {
  bootstrap (CourseRequest, [
    provide (Client, useFactory: () => new BrowserClient(), deps: [])
  ]);
}
