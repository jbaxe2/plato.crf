library plato.angular.services.application.error;

import 'dart:async' show StreamController;
import 'dart:html' show window;

import 'package:angular/core.dart';

import 'package:plato_angular/src/_application/error/plato_exception.dart';

/// The [ErrorService] class...
@Injectable()
class ErrorService {
  StreamController<PlatoException> errorStreamController;

  bool errorRaised;

  static ErrorService _instance;

  /// The [ErrorService] factory constructor...
  factory ErrorService() => _instance ?? (_instance = new ErrorService._());

  /// The [ErrorService] private constructor...
  ErrorService._() {
    errorStreamController = new StreamController<PlatoException>.broadcast();
    errorRaised = false;
  }

  /// The [raiseError] method...
  void raiseError (PlatoException exception) {
    window.console.log ('Encountered an error:\n${exception.toString()}');

    errorStreamController.add (exception);
    errorRaised = true;
  }
}
