library plato.angular.exceptions.plato;

/// The [PlatoException] class...
class PlatoException implements Exception {
  final String _message;

  /// The [PlatoException] constructor...
  PlatoException (
    [this._message = 'A Plato exception has occurred; details have not been specified.']
  );

  /// The [toString] method...
  @override
  String toString() => _message;
}
