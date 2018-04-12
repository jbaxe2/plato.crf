@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests.cross_listing;

import 'package:test/test.dart';

import 'dummy_objects.dart';

/// The [main] function...
void main() {
  group (
    'Cross-listing: ',
    () {
      testAddSectionToCrossListing();
      testRemoveSectionFromCrossListing();
      testIsValidForValidCrossListing();
      testIsValidForInvalidCrossListing();
      testIsCrossListableWith();
      testCrossListingContainsSection();
    }
  );
}

/// The [testAddSectionToCrossListing] function...
void testAddSectionToCrossListing() {
  test (
    'Add a section to the first cross-listing set.',
    () {
      firstCrossListing
        ..sections.clear()
        ..addSection (sections.first);

      expect ((0 < firstCrossListing.sections.length), true);
    }
  );
}

/// The [testRemoveSectionFromCrossListing] function...
void testRemoveSectionFromCrossListing() {
  test (
    'Remove a section from the first cross-listing set.',
    () {
      firstCrossListing
        ..sections.clear()
        ..addSection (sections.first)
        ..removeSection (sections.first);

      expect (firstCrossListing.sections.isEmpty, true);
    }
  );
}

/// The [testIsValidForValidCrossListing] function...
void testIsValidForValidCrossListing() {
  test (
    'Valid cross-listing set is correctly configured as valid.',
    () {
      firstCrossListing
        ..addSection (sections[0])
        ..addSection (sections[1]);

      expect (firstCrossListing.isValid, true);
    }
  );
}

/// The [testIsValidForInvalidCrossListing] function...
void testIsValidForInvalidCrossListing() {
  test (
    'Invalid cross-listing set is correctly configured as invalid.',
    () {
      firstCrossListing
        ..sections.clear()
        ..addSection (sections.first);

      expect (firstCrossListing.isValid, false);
    }
  );
}

/// The [testIsCrossListableWith] function...
void testIsCrossListableWith() {
  test (
    'Confirm a section can be added to a cross-listing set.',
    () {
      firstCrossListing
        ..sections.clear()
        ..addSection (sections.first);

      expect (firstCrossListing.isCrossListableWith (sections[1]), true);
    }
  );
}

/// The [testCrossListingContainsSection] function...
void testCrossListingContainsSection() {
  test (
    'Add section to cross-listing set; confirm the set contains it.',
    () {
      firstCrossListing
        ..sections.clear()
        ..addSection (sections.first);

      expect (firstCrossListing.contains (sections.first), true);
    }
  );
}
