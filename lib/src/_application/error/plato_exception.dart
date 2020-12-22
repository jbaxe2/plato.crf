library plato.crf.exceptions.plato;

import 'error_service.dart';

/// The [PlatoException] class...
class PlatoException implements Exception {
  final String message;

  /// The [PlatoException] constructor...
  PlatoException (
    [this.message = 'A Plato exception has occurred; details have not been specified.']
  ) {
    ErrorService().raiseError (this);
  }

  /// The [toString] method...
  @override
  String toString() => message;
}
