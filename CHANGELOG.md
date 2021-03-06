# Plato Course Request Form Changelog

## 1.3.20210127
- Minor cleaning up of code.

## 1.3.20201222
- Updated Dart SDK and dependency constraints.
- Work to update codebase to conform to newer Dart standards.

## 1.3.20191024
- Work on resolving LTI-based launch issues.
- Updated dependency constraints.

## 1.3.20191015
- Work to stabilize concurrent use of course request with archives viewer.

## 1.3.20191009
- More work on pushing archive viewing to the corresponding application.
- Updated dependency constraints.

## 1.3.20191008
- Start of removing course archive viewing capabilities, pushing to the course
archives viewing application instead.
- Updated minor version from 1.2 to 1.3 to indicate the level of change for the
application.

## 1.2.20190913
- Updated Dart SDK and dependency constraints.

## 1.2.20190326
- Updated dependency constraints.
- Work on component testing.

## 1.2.20190320
- Updated Dart SDK and dependency constraints.

## 1.2.20190222
- Updated Dart SDK and dependency constraints.

## 1.2.20190201
- Updated README.
- Updated dependency constraints.

## 1.2.20190119
- Removed remnants from old authentication scheme.

## 1.2.20190107
- Minor tweaking of language for user authorization component.

## 1.2.20190104
- Completed transitioning authentication method.
- Updated minor version from 1.1 to 1.2 to indicate the level of change for the
application.

## 1.1.20190103
- Start of transitioning authentication method to use 3-legged OAuth.
- Updated Dart SDK lower constraint to 2.1.0.
- Updated dependency constraints.

## 1.1.20181029
- Updated dependency constraints.

## 1.1.20181003
- Resolved cross-listing UI bugs.

## 1.1.20181002
- Tightened workflow controls and behavior for cross-listing sets.

## 1.1.20181001
- Work towards resolving remaining bugs.

## 1.1.20180928
- Updated dependencies (disabled pageloader dev dependency due to constraint
issues with build).
- Resolved bug where removing course from a cross-listing set while on the
previous content step was not reflected in previous content UI.

## 1.1.20180925
- Resolved layout issues to make application more mobile-friendly.
- Resolved an issue where removing previous content from a cross-listed
requested section did not remove it from the other sections in the cross-listing
set (just in the requested sections interface; it was correctly removed from the
request).
- Discovered a new behavioral bug:
  - If a section is removed from a cross-listing set while on the previous
  content step, this action should be reflected in the previous content UI.

## 1.1.20180924
- Work towards resolving behavioral bugs.

## 1.1.20180921
- Re-established the simplified preview of archived courses.
- Start of resolving behavioral bugs to 'finalize' 1.1.
- Current tests (created before 1.1) all pass again.
- Minor refactoring; removing 1.0-only code, conforming to Dart 2.0 best
practices, more consistency across code base.

## 1.1.20180920
- Various changes to UI, including adding/changing icons, container styling,
and other similar changes.

## 1.1.20180919
- Continuation of previous content workflow.
- Added course request review workflow.
- Minor improvements to UI consistency and quality.

## 1.1.20180918
- Continuation of cross-listing workflow.
- Start of removing old code that was commented out during UI transition.
- Start of previous content workflow.

## 1.1.20180917
- Continuation of cross-listing workflow.
- Various refactoring to better streamline UI.
- Minor revisions and updates to verbiage.

## 1.1.20180914
- Completed course selection workflow component.
- Started cross-listing workflow component.
- Minor updates on verbiage to users for directions on using the application.
- Removing all sections from the request now results in the user sent back to
the step for adding sections.
- Tightened consistency in behavior of the workflow.

## 1.1.20180913
- With new UI scheme, updated the versioning number.

## 1.0.20180913
- Resolved the courses typing issue.

## 1.0.20180912
- Continuing transitioning of UI.
- Resolving typing issues.

## 1.0.20180910
- Start of transitioning the UI to provide an easier workflow experience for
faculty requesting their courses.

## 1.0.20180811
- Resolved issues when building for testing purposes (regular build had worked
fine already).
- Start of resolving test issues that broke from changes to Dart 2.0 and/or
Angular.

## 1.0.20180809
- Resolved a tooltip directive import issue.
- Minor improvements.

## 1.0.20180807+1
- Resolved some new Angular and Dart 2.0 issues.
  - Enacted workaround for service issues where the HTTP Client could not access
  the response body, as per: https://github.com/dart-lang/http/issues/180. 

## 1.0.20180807
- Updated Dart SDK to 2.0.0.
- Updated dependency constraints, as apporpriate.

## 1.0.20180803
- Start of keeping an actual changelog.
- Build succeeds once again.

## 0.0.1
- Initial version, created by Stagehand
