# The Plato Course Request Form client, written in AngularDart.

This client application allows faculty at Westfield State University
to request course shells for use on Plato (Blackboard Learn).
  
Successful submission of the request results in real-time creation of
the faculty member's requested Blackboard courses (although archived
content must currently be manually loaded in, due to lack of API by
Blackboard, for which such courses will be created but instructors
denied access until the content has been loaded in).
 
Features currently include:
* Being context-aware for LTI-based launches.
* Authenticating Plato credentials, if needed.
* Requesting courses.
* Creating cross-listing sets that courses may be added to.
* Selecting previous content for each requested course, including
 archived course content.
  * For cross-listed courses, previous content applies to the
   parent shell, not the children.
* Previewing archived courses in a simplified view.
  * The preview displays the content areas for the course.
  * Content areas' content can be drilled down, folder by folder.
  * Linked files in the simplified view may be downloaded.
  * Currently does not support preview of discussions, tests,
   grade center, users, groups, etc.

The client is still a current work-in-progress, but is now *1.1*.

TODO:
* The Plato Archived Courses Viewer is currently being developed as
 a different project.  Once completed, this will take the place of
 the simplified archive viewer for this application.
* More tests must be written, including component tests.
* This application went through *major* interface changes with the
 transition from 1.0 to 1.1, and resulting code should be refactored.
