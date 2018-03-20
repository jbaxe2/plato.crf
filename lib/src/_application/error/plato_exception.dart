library plato.angular.exceptions.plato;

import 'package:plato_angular/src/_application/error/error_service.dart';

/// The [PlatoException] class...
class PlatoException implements Exception {
  final String message;

  /// The [PlatoException] constructor...
  PlatoException (
    [this.message = 'A Plato exception has occurred; details have not been specified.']
  ) {
    (new ErrorService()).raiseError (this);
  }

  /// The [toString] method...
  @override
  String toString() => message;
}
