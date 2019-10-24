library plato.crf.components.sections.requested;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../_application/workflow/workflow_service.dart';

import '../section.dart';

import 'requested_section_component.dart';
import 'requested_sections_service.dart';

/// The [RequestedSectionsComponent] class...
@Component(
  selector: 'requested-sections',
  templateUrl: 'requested_sections_component.html',
  styleUrls: ['requested_sections_component.css'],
  directives: [
    MaterialExpansionPanel, MaterialIconComponent, RequestedSectionComponent,
    NgIf, NgFor,
  ],
  providers: [
    RequestedSectionsService, WorkflowService
  ]
)
class RequestedSectionsComponent implements OnInit {
  List<Section> sections;

  final RequestedSectionsService _reqSectionsService;

  final WorkflowService _workflowService;

  /// The [RequestedSectionsComponent] constructor...
  RequestedSectionsComponent (this._reqSectionsService, this._workflowService) {
    sections = new List<Section>();
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    sections = _reqSectionsService.requestedSections;

    _reqSectionsService.haveSectionsListener.listen (_checkProgressWorkflow);
    _checkProgressWorkflow (sections.isNotEmpty);
  }

  /// The [_checkProgressWorkflow] method...
  void _checkProgressWorkflow (bool haveSections) {
    if (haveSections) {
      _workflowService.markCoursesSelected();
    } else {
      _workflowService.markSectionsReset();
    }
  }
}
