@TestOn('browser')
library plato.crf.tests.cross_listing;

import 'package:test/test.dart';

import 'dummy_objects.dart';

import 'testable.dart';

/// The [CrossListingTester] class...
class CrossListingTester implements Testable {
  /// The [CrossListingTester] constructor...
  CrossListingTester();

  /// The [run] method...
  @override
  void run() {
    group (
      'Cross-listing: ',
      () {
        _testAddSectionToCrossListing();
        _testRemoveSectionFromCrossListing();
        _testIsValidForValidCrossListing();
        _testIsValidForInvalidCrossListing();
        _testIsCrossListableWith();
        _testCrossListingContainsSection();
      }
    );
  }

  /// The [_testAddSectionToCrossListing] method...
  void _testAddSectionToCrossListing() {
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

  /// The [_testRemoveSectionFromCrossListing] method...
  void _testRemoveSectionFromCrossListing() {
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

  /// The [_testIsValidForValidCrossListing] method...
  void _testIsValidForValidCrossListing() {
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

  /// The [_testIsValidForInvalidCrossListing] method...
  void _testIsValidForInvalidCrossListing() {
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

  /// The [_testIsCrossListableWith] method...
  void _testIsCrossListableWith() {
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

  /// The [_testCrossListingContainsSection] method...
  void _testCrossListingContainsSection() {
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
}
