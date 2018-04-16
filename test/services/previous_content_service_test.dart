@Tags(const ['aot'])
@TestOn('browser')
library plato.angular.tests.services.previous_content;

import 'package:test/test.dart';

import 'package:plato_angular/src/previous_content/previous_content_service.dart';

import '../dummy_objects.dart';

/// The [main] function...
void main() {
  group (
    'Previous content: ',
    () {
      testCreatePreviousContent();
    }
  );
}

/// The [testCreatePreviousContent] function...
void testCreatePreviousContent() {
  test (
    'Create a previous content for the request.', () {
      var previousContentService = new PreviousContentService();
      courseRequest.clearAll();

      PreviousContentMapping previousContent =
        previousContentService.createPreviousContent (sections.first, enrollments.first);

      assert (previousContent.section == sections.first);
      assert (previousContent.enrollment == enrollments.first);
      assert (1 == courseRequest.previousContents.length);

      expect (
        courseRequest.previousContents.contains (previousContent), true
      );
    }
  );
}
