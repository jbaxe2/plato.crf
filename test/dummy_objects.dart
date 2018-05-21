library plato.crf.tests.models.dummy;

/// Silence analyzer: [CrossListingException]
import 'package:plato_crf/src/course_request/course_request.dart';
import 'package:plato_crf/src/cross_listings/cross_listing.dart';
import 'package:plato_crf/src/cross_listings/cross_listing_exception.dart';
import 'package:plato_crf/src/enrollments/enrollment.dart';
import 'package:plato_crf/src/previous_content/previous_content_mapping.dart';
import 'package:plato_crf/src/sections/section.dart';
import 'package:plato_crf/src/user/plato_user.dart';

export 'package:plato_crf/src/course_request/course_request.dart';
export 'package:plato_crf/src/cross_listings/cross_listing.dart';
export 'package:plato_crf/src/cross_listings/cross_listing_exception.dart';
export 'package:plato_crf/src/enrollments/enrollment.dart';
export 'package:plato_crf/src/previous_content/previous_content_mapping.dart';
export 'package:plato_crf/src/sections/section.dart';
export 'package:plato_crf/src/user/plato_user.dart';

var courseRequest = new CourseRequest();

var platoUser = new PlatoUser (
  'username', 'password', 'first', 'last', 'email@domain.com', 'A12345678`'
);

List<Section> sections = createSomeSections();
List<Enrollment> enrollments = createSomeEnrollments();

var firstCrossListing = new CrossListing();
var secondCrossListing = new CrossListing();

var firstPreviousContent = new PreviousContentMapping (sections.first, enrollments.first);
var lastPreviousContent = new PreviousContentMapping (sections.last, enrollments.last);

/// The [createSomeSections] function...
List<Section> createSomeSections() {
  var sections = new List<Section>();

  for (int i=0; i<5; i++) {
    var section = new Section (
      'section_id_$i', 'section_term', 'section_id_$i',
      'Section Title #$i', 'Faculty #$i', 'here', '-'
    );

    sections.add (section);
  }

  return sections;
}

/// The [createSomeEnrollments] function...
List<Enrollment> createSomeEnrollments() {
  var enrollments = new List<Enrollment>();

  for (int i=0; i<5; i++) {
    var enrollment = new Enrollment (
      'someuser', 'old_section_id_$i', 'Old Section Title #$i', 'Instructor', 'true'
    );

    enrollments.add (enrollment);
  }

  return enrollments;
}
