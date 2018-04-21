@TestOn('browser')
library plato.angular.tests.course_request;

import 'package:test/test.dart';

import 'dummy_objects.dart';

/// The [main] function...
void main() {
  group (
    'Course Request:',
    () {
      testAddAllSections();
      testClearAllSections();
      testClearAll();
      testSetUserAndAddSections();
      testAddNewCrossListing();
      testAddTwoSectionsToCrossListing();
      testAddOneSectionToTwoCrossListings();
      testAddFirstPreviousContent();
      testOverwriteFirstSectionPrevContentViaCl();
      testRemovePreviousContentForClSection();
      testAddPcToSectionInFirstClSet();
      testRemovePcFromFirstClSet();
      testAddPcSectionToClSet();
    }
  );
}

/// The [testAddAllSections] function...
void testAddAllSections() {
  test ('Add all sections to request.', () {
    courseRequest.addSections (createSomeSections());

    expect (0 < courseRequest.sections.length, true);

    courseRequest.removeAllSections();
  });
}

/// The [testClearAllSections] function...
void testClearAllSections() {
  test ('Clear all sections in the request.', () {
    firstCrossListing
      ..addSection (sections.first)
      ..addSection (sections[1]);

    secondCrossListing
      ..addSection (sections[2])
      ..addSection (sections[3]);

    courseRequest
      ..setPlatoUser (platoUser)
      ..addSections (createSomeSections())
      ..addCrossListing (firstCrossListing)
      ..addCrossListing (secondCrossListing)
      ..addPreviousContentMapping (firstPreviousContent)
      ..addPreviousContentMapping (lastPreviousContent)
      ..removeAllSections();

    expect (
      ((0 == courseRequest.sections.length) &&
       (0 == courseRequest.crossListings.length) &&
       (0 == courseRequest.previousContents.length)),
      true
    );

    courseRequest.clearAll();
  });
}

/// The [testClearAll] method...
void testClearAll() {
  test ('Create a full request and clear it.', () {
    firstCrossListing
      ..addSection (sections.first)
      ..addSection (sections[1]);

    secondCrossListing
      ..addSection (sections[2])
      ..addSection (sections[3]);

    courseRequest
      ..setPlatoUser (platoUser)
      ..addSections (createSomeSections())
      ..addCrossListing (firstCrossListing)
      ..addCrossListing (secondCrossListing)
      ..addPreviousContentMapping (firstPreviousContent)
      ..addPreviousContentMapping (lastPreviousContent);

    assert (courseRequest.submittable);

    courseRequest.clearAll();

    expect (
      ((null == courseRequest.platoUser) &&
       (0 == courseRequest.sections.length) &&
       (0 == courseRequest.crossListings.length) &&
       (0 == courseRequest.previousContents.length)),
      true
    );
  });
}

/// The [testSetUserAndAddSections] function...
void testSetUserAndAddSections() {
  test ('Set the user and add some sections to the request.', () {
    courseRequest
      ..setPlatoUser (platoUser)
      ..addSections (createSomeSections());

    expect (courseRequest.submittable, true);

    courseRequest.clearAll();
  });
}

/// The [testAddNewCrossListing] function...
void testAddNewCrossListing() {
  test ('Add the first cross-listing set to request.', () {
    courseRequest.addSections (createSomeSections());

    firstCrossListing
      ..addSection (sections.first)
      ..addSection (sections[1]);

    courseRequest.addCrossListing (firstCrossListing);

    expect ((0 < courseRequest.crossListings.length), true);

    courseRequest.removeAllSections();
  });
}

/// The [testAddTwoSectionsToCrossListing] function...
void testAddTwoSectionsToCrossListing() {
  test ('Add two sections to the first cross-listing set.', () {
    courseRequest
      ..crossListings.clear()
      ..addSections (createSomeSections())
      ..addCrossListing (firstCrossListing)
      ..addSectionToCrossListing (sections.first, firstCrossListing)
      ..addSectionToCrossListing (sections[1], firstCrossListing);

    assert (courseRequest.crossListings.first == firstCrossListing);

    expect ((1 < courseRequest.crossListings.first.sections.length), true);

    courseRequest.removeAllSections();
  });
}

/// The [testAddOneSectionToTwoCrossListings] function...
void testAddOneSectionToTwoCrossListings() {
  test ('Add one section to two different cross-listing sets.', () {
    courseRequest
      ..crossListings.clear()
      ..addSections (createSomeSections())
      ..addCrossListing (firstCrossListing)
      ..addSectionToCrossListing (sections.first, firstCrossListing)
      ..addSectionToCrossListing (sections[1], firstCrossListing)
      ..addCrossListing (secondCrossListing);

    try {
      courseRequest.addSectionToCrossListing (sections.first, secondCrossListing);
    } catch (e) {
      assert (e is CrossListingException);

      String error = 'The specified section is part of a different cross-listing set.';

      expect (e.toString() == error, true);
    }

    courseRequest.removeAllSections();
  });
}

/// The [testAddFirstPreviousContent] function...
void testAddFirstPreviousContent() {
  test ('Add the first previous content to request.', () {
    courseRequest
      ..setPlatoUser (platoUser)
      ..addSections (createSomeSections())
      ..addPreviousContentMapping (firstPreviousContent);

    expect ((0 < courseRequest.previousContents.length), true);

    courseRequest.clearAll();
  });
}

/// The [testOverwriteFirstSectionPrevContentViaCl] function...
void testOverwriteFirstSectionPrevContentViaCl() {
  test (
    'Change previous content enrollment in a cross-listed section, that overwrites '
      'the previous content of the other section in the set.',
    () {
      courseRequest
        ..setPlatoUser (platoUser)
        ..addSections (createSomeSections())
        ..addPreviousContentMapping (firstPreviousContent)
        ..setPreviousContentEnrollment (firstPreviousContent, enrollments[2]);

      expect (
        (courseRequest.previousContents.first.enrollment == enrollments[2]),
        true
      );

      courseRequest.clearAll();
    }
  );
}

/// The [testRemovePreviousContentForClSection] function...
void testRemovePreviousContentForClSection() {
  test (
    'Removing previous content for section in first cross-listing set '
      'removes it from all sections in the set (but no other sets).',
    () {
      firstCrossListing
        ..sections.clear()
        ..addSection (sections.first)
        ..addSection (sections[1]);

      courseRequest
        ..setPlatoUser (platoUser)
        ..previousContents.clear()
        ..crossListings.clear()
        ..addSections (createSomeSections())
        ..addCrossListing (firstCrossListing)
        ..addPreviousContentMapping (firstPreviousContent)
        ..removePreviousContentForSection (sections.first);

      CrossListing crossListing =
        courseRequest.getCrossListingForSection (sections.first);

      bool result = crossListing.sections.every ((Section section) {
        return (null == courseRequest.getPreviousContentForSection (section));
      });

      expect (result, true);

      courseRequest.clearAll();
    }
  );
}

/// The [testAddPcToSectionInFirstClSet] function...
void testAddPcToSectionInFirstClSet() {
  test (
    'Add previous content to a section that is cross-listed with another section, '
      'whereby a different cross-listing set is unaffected.',
    () {
      firstCrossListing.sections
        ..clear()
        ..addAll ([sections.first, sections[1]]);

      secondCrossListing.sections
        ..clear()
        ..addAll ([sections[2], sections.last]);

      courseRequest
        ..addSections (createSomeSections())
        ..crossListings.clear()
        ..addCrossListing (firstCrossListing)
        ..addCrossListing (secondCrossListing);

      courseRequest
        ..setPlatoUser (platoUser)
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

      courseRequest.clearAll();
    }
  );
}

/// The [testRemovePcFromFirstClSet] function...
void testRemovePcFromFirstClSet() {
  test (
    'Remove previous content for a section in a cross-listing set, with all courses '
      'losing previous content, whereby another cross-listing set is unaffected.',
    () {
      firstCrossListing.sections
        ..clear()
        ..addAll ([sections.first, sections[1]]);

      secondCrossListing.sections
        ..clear()
        ..addAll ([sections[2], sections.last]);

      courseRequest
        ..crossListings.clear()
        ..addSections (createSomeSections())
        ..addCrossListing (firstCrossListing)
        ..addCrossListing (secondCrossListing);

      courseRequest
        ..setPlatoUser (platoUser)
        ..previousContents.clear()
        ..addPreviousContentMapping (firstPreviousContent)
        ..addPreviousContentMapping (lastPreviousContent)
        ..removePreviousContentForSection (sections.first);

      CrossListing crossListing = courseRequest.getCrossListingForSection (sections.first);

      bool result = crossListing.sections.every ((Section section) {
        return (null == courseRequest.getPreviousContentForSection (section));
      });

      expect (result, true);

      courseRequest.clearAll();
    }
  );
}

/// The [testAddPcSectionToClSet] function...
void testAddPcSectionToClSet() {
  test (
    'Add a section with previous content to a cross-listing set, then add another '
      'section to the same set without previous content; confirm both sections '
      'have the same previous content.',
    () {
      courseRequest
        ..setPlatoUser (platoUser)
        ..addSections (createSomeSections())
        ..previousContents.clear()
        ..crossListings.clear()
        ..addPreviousContentMapping (firstPreviousContent)
        ..addCrossListing (firstCrossListing)
        ..addSectionToCrossListing (sections.first, firstCrossListing)
        ..addSectionToCrossListing (sections[1], firstCrossListing);

      PreviousContentMapping secondPrevContent =
        courseRequest.getPreviousContentForSection (firstCrossListing.sections[1]);

      assert (null != secondPrevContent);

      expect ((firstPreviousContent.enrollment == secondPrevContent.enrollment), true);

      courseRequest.clearAll();
    }
  );
}
