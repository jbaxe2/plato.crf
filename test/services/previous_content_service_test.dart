@TestOn('browser')
library plato.crf.tests.services.previous_content;

import 'package:test/test.dart';

import 'package:plato_crf/src/previous_content/previous_content_service.dart';
import 'package:plato_crf/src/previous_content/previous_content_exception.dart';

import '../testable.dart';

import '../dummy_objects.dart';

/// The [main] function...
void main() => (new PreviousContentServiceTester()).run();

/// The [PreviousContentServiceTester] class...
class PreviousContentServiceTester implements Testable {
  /// The [PreviousContentServiceTester] constructor...
  PreviousContentServiceTester();

  /// The [run] method...
  @override
  void run() {
    group (
      'Previous content:',
      () {
        _testCreatePreviousContent();
        _testAddPreviousContent();
        _testAddPreviousContentTwice();
        _testRemovePreviousContent();
      }
    );
  }

  /// The [_testCreatePreviousContent] method...
  void _testCreatePreviousContent() {
    test (
      'Create a previous content for the request.',
      () {
        var previousContentService = new PreviousContentService();

        courseRequest.setPlatoUser (platoUser);

        PreviousContentMapping previousContent =
          previousContentService.createPreviousContent (sections.first, enrollments.first);

        assert (previousContent.section == sections.first);
        assert (previousContent.enrollment == enrollments.first);
        assert (1 == courseRequest.previousContents.length);

        expect (
          courseRequest.previousContents.contains (previousContent), true
        );

        courseRequest.clearAll();
      }
    );
  }

  /// The [_testAddPreviousContent] method...
  void _testAddPreviousContent() {
    test (
      'Add previous content to the course request.',
      () {
        courseRequest
          ..setPlatoUser (platoUser)
          ..previousContents.clear();

        (new PreviousContentService())
          ..addPreviousContent (firstPreviousContent);

        expect (
          courseRequest.previousContents.contains (firstPreviousContent), true
        );

        courseRequest.clearAll();
      }
    );
  }

  /// The [_testAddPreviousContentTwice] method...
  void _testAddPreviousContentTwice() {
    test (
      'Adding the same previous content twice fails.',
      () {
        courseRequest
          ..setPlatoUser (platoUser)
          ..previousContents.clear();

        var previousContentService = new PreviousContentService()
          ..addPreviousContent (firstPreviousContent);

        try {
          previousContentService.addPreviousContent (firstPreviousContent);
        } catch (e) {
          assert (e is PreviousContentException);

          String error = 'Cannot add a previous content mapping for a section '
            'that already contains other previous content.';

          expect ((e.toString() == error), true);
        }

        courseRequest.clearAll();
      }
    );
  }

  /// The [_testRemovePreviousContent] method...
  void _testRemovePreviousContent() {
    test (
      'Remove previous content from the course request.',
      () {
        courseRequest
          ..setPlatoUser (platoUser)
          ..previousContents.clear();

        var previousContentService = new PreviousContentService()
          ..addPreviousContent (firstPreviousContent);

        assert (courseRequest.previousContents.contains (firstPreviousContent));

        previousContentService.removePreviousContent (firstPreviousContent);

        expect (
          courseRequest.previousContents.contains (firstPreviousContent), false
        );
      }
    );
  }
}
