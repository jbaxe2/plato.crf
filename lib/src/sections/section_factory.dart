library plato.angular.factory.section;

import '../_application/factory/plato_factory.dart';

import 'section.dart';
import 'section_exception.dart';

/// The [SectionFactory] class...
class SectionFactory implements PlatoFactory<Section> {
  /// The [SectionFactory] default constructor...
  SectionFactory();

  /// The [create] method...
  @override
  Section create (Map<String, dynamic> rawSection) {
    if (!(rawSection.containsKey ('crsno') &&
          rawSection.containsKey ('term') &&
          rawSection.containsKey ('title') &&
          rawSection.containsKey ('facname') &&
          rawSection.containsKey ('mplace') &&
          rawSection.containsKey ('mtime'))) {
      throw new SectionException (
        'The provided section information was not properly formatted.'
      );
    }

    String faculty = rawSection['facname'].trim();

    if ('' == faculty) {
      faculty = 'Staff';
    }

    return new Section (
      rawSection['crsno'], rawSection['term'], rawSection['crsno'],
      rawSection['title'], faculty, rawSection['mplace'], rawSection['mtime']
    );
  }

  /// The [createAll] method...
  @override
  List<Section> createAll (Iterable<Map<String, dynamic>> rawSections) {
    var sections = new List<Section>();

    rawSections.forEach (
      (Map<String, dynamic> rawSection) => sections.add (create (rawSection))
    );

    return sections;
  }
}
