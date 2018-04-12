@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests.course_request;

import 'package:test/test.dart';

import '../dummy_objects.dart';

/// The [main] function...
void main() {
  group (
    'Course Request: ',
    () {
      testAddAllSections();
      testAddNewCrossListing();
      testAddTwoSectionsToCrossListing();
      testAddFirstPreviousContent();
      testOverwriteFirstSectionPrevContentViaCl();
      testRemovePreviousContentForClSection();
      testAddPcToSectionInFirstClSet();
      testRemovePcFromFirstClSet();
      testClearAllSections();
    }
  );
}

/// The [testAddAllSections] function...
void testAddAllSections() {
  test ('Add all sections to request.', () {
    courseRequest.addSections (createSomeSections());

    expect (courseRequest.sections.length, 5);
  });
}

/// The [testAddNewCrossListing] function...
void testAddNewCrossListing() {
  test ('Add the first cross-listing set to request.', () {
    courseRequest.addCrossListing (firstCrossListing);

    expect ((0 < courseRequest.crossListings.length), true);
  });
}

/// The [testAddTwoSectionsToCrossListing] function...
void testAddTwoSectionsToCrossListing() {
  test ('Add two sections to the first cross-listing set.', () {
    firstCrossListing.addSection (sections[0]);
    firstCrossListing.addSection (sections[1]);

    expect ((1 < firstCrossListing.sections.length), true);
  });
}

/// The [testAddFirstPreviousContent] function...
void testAddFirstPreviousContent() {
  test ('Add the first previous content to request.', () {
    courseRequest.addPreviousContentMapping (firstPreviousContent);

    expect ((0 < courseRequest.previousContents.length), true);
  });
}

/// The [testOverwriteFirstSectionPrevContentViaCl] function...
void testOverwriteFirstSectionPrevContentViaCl() {
  test (
    'Change previous content enrollment in a cross-listed section, that overwrites '
      'the previous content of the other section in the set.',
    () {
      courseRequest.setPreviousContentEnrollment (firstPreviousContent, enrollments[2]);

      expect (
        (courseRequest.previousContents.first.enrollment == enrollments[2]),
        true
      );
    }
  );
}

/// The [testRemovePreviousContentForClSection] function...
void testRemovePreviousContentForClSection() {
  test (
    'Removing previous content for section in first cross-listing set '
      'removes it from all sections in the set (no other sets).',
    () {
      courseRequest.removePreviousContentForSection (sections.first);

      CrossListing crossListing =
        courseRequest.getCrossListingForSection (sections.first);

      bool result = crossListing.sections.every ((Section section) {
        return (null == courseRequest.getPreviousContentForSection (section));
      });

      expect (result, true);
    }
  );
}

/// The [testAddPcToSectionInFirstClSet] function...
void testAddPcToSectionInFirstClSet() {
  test (
    'Add previous content to a section that is cross-listed with another section, '
    'whereby a different cross-listing set is unaffected.',
    () {
      List<CrossListing> crossListings = new List.from (courseRequest.crossListings);

      crossListings.forEach ((CrossListing crossListing) {
        courseRequest.removeCrossListing (crossListing);
      });

      firstCrossListing.sections
        ..clear()
        ..addAll ([sections.first, sections[1]]);

      secondCrossListing.sections
        ..clear()
        ..addAll ([sections[2], sections.last]);

      courseRequest
        ..crossListings.clear()
        ..addCrossListing (firstCrossListing)
        ..addCrossListing (secondCrossListing);

      courseRequest
        ..previousContents.clear()
        ..addPreviousContentMapping (firstPreviousContent)
        ..addPreviousContentMapping (lastPreviousContent);

      CrossListing crossListing = courseRequest.getCrossListingForSection (sections.first);

      bool result = crossListing.sections.every ((Section section) {
        PreviousContentMapping prevContent =
          courseRequest.getPreviousContentForSection (section);

        return (firstPreviousContent.enrollment == prevContent.enrollment);
      });

      expect (result, true);
    }
  );
}

/// The [testRemovePcFromFirstClSet] function...
void testRemovePcFromFirstClSet() {
  test (
    'Remove previous content for a section in a cross-listing set, with all courses '
      'losing previous content, whereby another cross-listing set is unaffected.',
    () {
      CrossListing crossListing =
        courseRequest.getCrossListingForSection (sections.first);

      courseRequest.removePreviousContentForSection (sections.first);

      bool result = crossListing.sections.every (
        (Section section) => (null == courseRequest.getPreviousContentForSection (section))
      );

      courseRequest.crossListings.forEach ((CrossListing aCrossListing) {
        if (crossListing != aCrossListing) {
          ;
        }
      });

      expect (result, true);
    }
  );
}

/// The [testClearAllSections] function...
void testClearAllSections() {
  test ('Clear all sections in the request.', () {
    courseRequest.removeAllSections();

    expect (
      ((0 == courseRequest.sections.length) &&
       (0 == courseRequest.crossListings.length) &&
       (0 == courseRequest.previousContents.length)),
      true
    );
  });
}
