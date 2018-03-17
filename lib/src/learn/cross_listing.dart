library plato.angular.models.learn.cross_listing;

import '../banner/section.dart';

/// The [CrossListing] class...
class CrossListing {
  List<Section> sections;

  bool get isValid => (1 < sections.length);

  /// The [CrossListing] constructor...
  CrossListing() {
    sections = new List<Section>();
  }

  /// The [isCrossListableWith] method...
  bool isCrossListableWith (Section section) {
    if (sections.isEmpty) {
      return true;
    }

    if ((sections.first.isDay() && section.isDay()) ||
        !(sections.first.isDay() || section.isDay())) {
      return true;
    }

    if (!(('online' == sections.first.place.trim().toLowerCase()) ||
          ('online' == section.place.trim().toLowerCase()))) {
      return true;
    }

    return false;
  }

  /// The [addSection] method...
  void addSection (Section section) {
    if (!sections.contains (section) && isCrossListableWith (section)) {
      sections.add (section);
      sections.sort();
    }
  }

  /// The [removeSection] method...
  bool removeSection (Section section) {
    if (sections.contains (section)) {
      return sections.remove (section);
    }

    return false;
  }

  /// The [contains] method...
  bool contains (Section section) => sections.contains (section);

  /// The [==] operator...
  @override
  bool operator ==(dynamic other) {
    if (identical (other, this)) {
      return true;
    }

    if (other is CrossListing) {
      try {
        if (sections.every ((section) => other.sections.contains (section)) &&
            other.sections.every ((oSection) => sections.contains (oSection))) {
          return true;
        }
      } catch (_) {}
    }

    return false;
  }

  /// The [hashCode] getter...
  @override
  int get hashCode {
    int result = 3;

    sections.forEach (
      (Section section) => (result = 7 * result + section.hashCode)
    );

    return result;
  }
}
