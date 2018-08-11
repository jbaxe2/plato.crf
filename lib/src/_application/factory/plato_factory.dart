library plato.crf.factory.plato;

/// The [PlatoFactory] abstract class...
abstract class PlatoFactory<T> {
  /// The [create] method...
  T create (covariant Map<String, Object> rawInput);

  /// The [createAll] method...
  Iterable<T> createAll (covariant Iterable<Map<String, Object>> rawInputs);
}
