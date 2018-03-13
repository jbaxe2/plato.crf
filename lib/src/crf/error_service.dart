library plato.angular.services.crf.error;

import 'dart:async' show StreamController;

import 'package:angular/core.dart';

import 'plato_exception.dart';

/// The [ErrorService] class...
@Injectable()
class ErrorService {
  PlatoException _exception;

  PlatoException get exception => _exception;

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
  void raiseError (PlatoException theException) {
    _exception = theException;
    errorRaised = true;

    errorStreamController.add (theException);
  }
}
