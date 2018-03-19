library plato.angular.models.term;

/// The [Term] class...
class Term {
  String id;

  String description;

  /// The [Term] constructor...
  Term (this.id, this.description);

  /// The [==] operator...
  @override
  bool operator ==(dynamic other) {
    if (other is Term) {
      if ((other.id == id) &&
          (other.description == description)) {
        return true;
      }
    }

    return false;
  }

  /// The [hashCode] getter...
  @override
  int get hashCode {
    int result = 3;

    result = 7 * result + ((null == id) ? 0 : id.hashCode);
    result = 7 * result + ((null == description) ? 0 : description.hashCode);

    return result;
  }
}
