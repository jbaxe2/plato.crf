library plato.crf.services.application.error;

import 'dart:async' show StreamController;

import 'plato_exception.dart';

/// The [ErrorService] class...
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
    errorStreamController.add (exception);
    errorRaised = true;
  }
}
