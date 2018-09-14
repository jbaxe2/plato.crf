library plato.crf.components.sections.requesting;

import 'package:angular/angular.dart';

import '../../_application/workflow/workflow_service.dart';

import '../../course_request/course_request_service.dart';

import '../../courses/courses_component.dart';

import '../../departments/departments_component.dart';

import '../../terms/terms_component.dart';

import '../selection/sections_selection_component.dart';

/// The [RequestingSectionsComponent] class...
@Component(
  selector: 'requesting-sections',
  templateUrl: 'requesting_sections_component.html',
  directives: const [
    DepartmentsComponent, TermsComponent, CoursesComponent,
    SectionsSelectionComponent
  ],
  providers: const [CourseRequestService, WorkflowService]
)
class RequestingSectionsComponent implements OnInit {
  final CourseRequestService _courseRequestService;

  final WorkflowService _workflowService;

  /// The [RequestingSectionsComponent] constructor...
  RequestingSectionsComponent (this._courseRequestService, this._workflowService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    if (_courseRequestService.haveCourses()) {
      _workflowService.markCoursesSelected();
    }
  }
}
