library plato.crf.factory.plato;

/// The [PlatoFactory] abstract class...
abstract class PlatoFactory<T> {
  /// The [create] method...
  T create (Map<String, dynamic> rawInput);

  /// The [createAll] method...
  Iterable<T> createAll (Iterable<Map<String, dynamic>> rawInputs);
}
