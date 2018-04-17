library plato.angular;

import 'dart:async' show runZoned;
import 'dart:html' show window;

import 'package:angular/angular.dart';

import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'package:plato_angular/src/course_request/course_request_component.dart';

/// The [main] function...
void main() {
  runZoned (() {
    /// TODO: use 'runApp' instead of 'bootstrapStatic'.
    bootstrapStatic (CourseRequestComponent, [
      provide (Client, useFactory: () => new BrowserClient(), deps: [])
    ]);
  }, onError: (e) {
    window.console.log ('Uncaught error:\n${e.toString()}');
  });
}
