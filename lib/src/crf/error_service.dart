library plato.angular.services.crf.error;

import 'package:plato_angular/src/crf/plato_exception.dart';

/// The [ErrorService] class...
class ErrorService {
  PlatoException _exception;

  PlatoException get exception => _exception;

  bool errorRaised;

  static ErrorService _instance;

  /// The [ErrorService] factory constructor...
  factory ErrorService() => _instance ?? (_instance = new ErrorService._());

  /// The [ErrorService] private constructor...
  ErrorService._() {
    errorRaised = false;
  }

  /// The [raiseError] method...
  void raiseError (PlatoException theException) {
    _exception = theException;
    errorRaised = true;
  }
}
