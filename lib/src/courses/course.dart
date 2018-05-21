library plato.crf.models.course;

/// The [Course] class...
class Course {
  final String id;

  final String title;

  /// The [Course] constructor...
  Course (this.id, this.title);

  /// The [==] operator...
  @override
  bool operator ==(dynamic other) {
    if (other is Course) {
      if ((other.id == id) &&
          (other.title == title)) {
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
    result = 7 * result + ((null == title) ? 0 : title.hashCode);

    return result;
  }
}
