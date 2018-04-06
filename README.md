# The Plato Course Request Form client, written in AngularDart.

In preparation for *Dart 2.0*, the *Plato Course Request Form* was re-written
using AngularDart (instead of keeping with PolymerDart, which has not been updated).

This client application allows faculty at Westfield State University to request
 courses for use on Plato (Blackboard Learn).  Successful submission of the
 request results in near-real-time creation of the courses.
 
Features currently include:
* Authenticating Plato credentials, if needed
* Being context-aware for LTI-based launches
* Requesting courses
* Creating cross-listing sets that courses may be added to
* Selecting previous content for each requested course, including archived course
 content
  * For cross-listed courses, previous content applies to the parent shell, not
 the children
* Previewing archived courses in a simplified view
  * The preview displays the content areas for the course
  * Content areas' content can be drilled down, folder by folder
  * Linked files in the simplified view may be downloaded

The client is still a current work-in-progress, but is now *1.0*.
