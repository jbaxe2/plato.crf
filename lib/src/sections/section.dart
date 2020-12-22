library plato.crf.models.section;

import 'section_exception.dart';

/// The [Section] class...
class Section implements Comparable {
  final String sectionId;

  final String termId;

  final String crn;

  final String title;

  final String faculty;

  final String place;

  final String time;

  /// The [Section] constructor...
  Section (
    this.sectionId, this.termId, this.crn, this.title, this.faculty,
    this.place, this.time
  );

  /// The [isDay] method...
  bool isDay() {
    var digitStr = sectionId.substring (
      (sectionId.length - 3), (sectionId.length - 2)
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
    if (identical (other, this)) {
      return true;
    }

    if (other is Section) {
      if ((other.sectionId == sectionId) &&
          (other.termId == termId) &&
          (other.crn == crn) &&
          (other.title == title) &&
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
    var result = 3;

    result = 7 * result + ((null == sectionId) ? 0 : sectionId.hashCode);
    result = 7 * result + ((null == termId) ? 0 : termId.hashCode);
    result = 7 * result + ((null == crn) ? 0 : crn.hashCode);
    result = 7 * result + ((null == title) ? 0 : title.hashCode);
    result = 7 * result + ((null == faculty) ? 0 : faculty.hashCode);
    result = 7 * result + ((null == place) ? 0 : place.hashCode);
    result = 7 * result + ((null == time) ? 0 : time.hashCode);

    return result;
  }

  /// The [compareTo] method...
  @override
  int compareTo (dynamic other) {
    if (!(other is Section)) {
      throw SectionException ('Cannot compare a section to some other type.');
    }

    return sectionId.compareTo (other.sectionId);
  }

  /// The [toJson] method...
  Object toJson() {
    return {
      'sectionId': sectionId,
      'crn': crn,
      'courseTitle': title,
      'termId': termId,
      'faculty': faculty,
      'time': time,
      'place': place
    };
  }
}
