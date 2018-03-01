library plato.angular.models.banner.section;

/// The [Section] class...
class Section {
  String courseId;

  String termId;

  String crn;

  String faculty;

  String place;

  String time;

  /// The [Section] constructor...
  Section (this.courseId, this.termId, this.crn, this.faculty, this.place, this.time);

  /// The [isDay] method...
  bool isDay() {
    String digitStr = courseId.substring (
      (courseId.length - 3), (courseId.length - 2)
    );

    // Dual enrollment, and CGCE sections for Day division cross-registration.
    if (('R' == digitStr) || ('H' == digitStr) || ('P' == digitStr)) {
      return true;
    }

    try {
      return (5 == int.parse (digitStr)) ? false : true;
    } catch (e) {}

    // If it is indeterminable that the course is Day, default to false.
    return false;
  }

  /// The [==] operator...
  @override
  bool operator ==(dynamic other) {
    if (other is Section) {
      if ((other.courseId == courseId) &&
          (other.termId == termId) &&
          (other.crn == crn) &&
          (other.faculty == faculty) &&
          (other.place == place) &&
          (other.time == time)) {
        return true;
      }
    }

    return false;
  }

  /// The [hashCode] getter...
  @override
  int get hashCode {
    int result = 3;

    result = 7 * result + ((null == courseId) ? 0 : courseId.hashCode);
    result = 7 * result + ((null == termId) ? 0 : termId.hashCode);
    result = 7 * result + ((null == crn) ? 0 : crn.hashCode);
    result = 7 * result + ((null == faculty) ? 0 : faculty.hashCode);
    result = 7 * result + ((null == place) ? 0 : place.hashCode);
    result = 7 * result + ((null == time) ? 0 : time.hashCode);

    return result;
  }
}
