library plato.angular.models.learn.cross_listing;

import '../banner/section.dart';

/// The [CrossListing] class...
class CrossListing {
  List<Section> sections;

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
}
