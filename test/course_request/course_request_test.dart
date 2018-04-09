library plato.angular.tests.course_request;

import 'package:test/test.dart';

import '../dummy_objects.dart';

/// The [testCourseRequest] function...
void testCourseRequest() {
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
    expect (
      courseRequest.addSections (createSomeSections()),
      (5 == courseRequest.sections.length)
    );
  });
}

/// The [testAddNewCrossListing] function...
void testAddNewCrossListing() {
  test ('Add new cross-listing set to request', () {
    expect (
      courseRequest.addCrossListing (firstCrossListing),
      (0 < courseRequest.crossListings.length)
    );
  });
}

/// The [testAddTwoSectionsToCrossListing] function...
void testAddTwoSectionsToCrossListing() {
  test ('Add two sections to the cross-listing set', () {
    expect (
      () {
        firstCrossListing.addSection (sections[0]);
        firstCrossListing.addSection (sections[1]);
      },
      (1 < firstCrossListing.sections.length)
    );
  });
}

/// The [testAddPreviousContent] function...
void testAddPreviousContent() {
  test ('Add previous content to request', () {
    expect (
      courseRequest.addPreviousContentMapping (firstPreviousContent),
      (0 < courseRequest.previousContents.length)
    );
  });
}

/// The [testOverwriteFirstSectionPrevContentViaCl] function...
void testOverwriteFirstSectionPrevContentViaCl() {
  test (
    'Add previous content to a cross-listed section, that overwrites '
      'the previous content of the other section in the set.',
    () {
      expect (
        courseRequest.addPreviousContentMapping (
          new PreviousContentMapping(sections[1], enrollments[2])
        ),
        (courseRequest.previousContents.first.enrollment == enrollments[2])
      );
    }
  );
}

/// The [testClearAllSections] function...
void testClearAllSections() {
  test ('Clear all sections', () {
    expect (
      courseRequest.removeAllSections(),
      allOf ([
        (0 == courseRequest.sections.length),
        (0 == courseRequest.crossListings.length),
        (0 == courseRequest.previousContents.length)
      ])
    );
  });
}
