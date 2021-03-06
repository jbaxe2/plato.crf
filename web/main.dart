library plato.crf;

import 'dart:async' show runZoned;
import 'dart:html' show window;

import 'package:angular/angular.dart';

import 'package:http/http.dart' show Client;
import 'package:http/browser_client.dart' show BrowserClient;

// ignore: uri_has_not_been_generated
import 'package:plato.crf/src/course_request/course_request_component.template.dart' as cr;

// ignore: uri_has_not_been_generated
import 'main.template.dart' as cr_main;

/// Generate the [BrowserClient] injector...
@GenerateInjector(
  [ClassProvider (Client, useClass: BrowserClient)]
)
final InjectorFactory clientInjector = cr_main.clientInjector$Injector;

/// The [main] function...
void main() {
  runZoned (() {
    runApp (cr.CourseRequestComponentNgFactory, createInjector: clientInjector);
  }, onError: (e) {
    window.console.log ('Uncaught error:\n${e.toString()}');
  });
}
