@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests.services.previous_content;

import 'package:test/test.dart';

import 'package:plato_angular/src/previous_content/previous_content_service.dart';
import 'package:plato_angular/src/previous_content/previous_content_exception.dart';

import '../dummy_objects.dart';

/// The [main] function...
void main() {
  group (
    'Previous content:',
    () {
      testCreatePreviousContent();
      testAddPreviousContent();
      testAddPreviousContentTwice();
      testRemovePreviousContent();
    }
  );
}

/// The [testCreatePreviousContent] function...
void testCreatePreviousContent() {
  test (
    'Create a previous content for the request.', () {
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

/// The [testAddPreviousContent] function...
void testAddPreviousContent() {
  test (
    'Add previous content to the course request.', () {
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

/// The [testAddPreviousContentTwice] function...
void testAddPreviousContentTwice() {
  test (
    'Adding the same previous content twice fails.', () {
      courseRequest
        ..setPlatoUser (platoUser)
        ..previousContents.clear();

      var previousContentService = new PreviousContentService()
        ..addPreviousContent (firstPreviousContent);

      try {
        previousContentService.addPreviousContent (firstPreviousContent);
      } catch (e) {
        assert (e is PreviousContentException);

        String error = 'Cannot add a previous content mapping for a section that already '
          'contains other previous content.';

        expect ((e.toString() == error), true);
      }

      courseRequest.clearAll();
    }
  );
}

/// The [testRemovePreviousContent] function...
void testRemovePreviousContent() {
  test (
    'Remove previous content from the course request.', () {
      courseRequest
        ..setPlatoUser (platoUser)
        ..previousContents.clear();

      var previousContentService = new PreviousContentService()
        ..addPreviousContent (firstPreviousContent);

      assert (courseRequest.previousContents.contains (firstPreviousContent));

      previousContentService.removePreviousContent (firstPreviousContent);

      expect (
        courseRequest.previousContents.contains (firstPreviousContent),
        false
      );
    }
  );
}
