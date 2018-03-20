library plato.angular;

import 'dart:async' show runZoned;

import 'package:angular/angular.dart';

import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'package:plato_angular/src/course_request/course_request_component.dart';

/// The [main] function...
void main() {
  runZoned (() {
    bootstrap (CourseRequestComponent, [
      provide (Client, useFactory: () => new BrowserClient(), deps: [])
    ]);
  }, onError: () {});
}
