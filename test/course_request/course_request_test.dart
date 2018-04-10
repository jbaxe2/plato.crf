@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests.course_request;

import 'package:test/test.dart';

import '../dummy_objects.dart';

/// The [main] function...
void main() {
  testAddAllSections();
  testAddNewCrossListing();
  testAddTwoSectionsToCrossListing();
  testAddPreviousContent();
  testOverwriteFirstSectionPrevContentViaCl();
  testClearAllSections();
}

/// The [testAddAllSections] function...
void testAddAllSections() {
  test ('Add all sections to request', () {
    courseRequest.addSections (createSomeSections());

    expect (courseRequest.sections.length, 5);
  });
}

/// The [testAddNewCrossListing] function...
void testAddNewCrossListing() {
  test ('Add the first cross-listing set to request', () {
    courseRequest.addCrossListing (firstCrossListing);

    expect ((0 < courseRequest.crossListings.length), true);
  });
}

/// The [testAddTwoSectionsToCrossListing] function...
void testAddTwoSectionsToCrossListing() {
  test ('Add two sections to the first cross-listing set', () {
    firstCrossListing.addSection (sections[0]);
    firstCrossListing.addSection (sections[1]);

    expect ((1 < firstCrossListing.sections.length), true);
  });
}

/// The [testAddPreviousContent] function...
void testAddPreviousContent() {
  test ('Add previous content to request', () {
    courseRequest.addPreviousContentMapping (firstPreviousContent);

    expect ((0 < courseRequest.previousContents.length), true);
  });
}

/// The [testOverwriteFirstSectionPrevContentViaCl] function...
void testOverwriteFirstSectionPrevContentViaCl() {
  test (
    'Add previous content to a cross-listed section, that overwrites '
      'the previous content of the other section in the set.',
    () {
      courseRequest.addPreviousContentMapping (
        new PreviousContentMapping (sections[1], enrollments[2])
      );

      expect (
        (courseRequest.previousContents.first.enrollment == enrollments[2]),
        true
      );
    }
  );
}

/// The [testClearAllSections] function...
void testClearAllSections() {
  test ('Clear all sections', () {
    courseRequest.removeAllSections();

    expect (
      ((0 == courseRequest.sections.length) &&
       (0 == courseRequest.crossListings.length) &&
       (0 == courseRequest.previousContents.length)),
      true
    );
  });
}
