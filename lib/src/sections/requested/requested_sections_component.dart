library plato.crf.components.sections.requested;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../section.dart';

import 'requested_section_component.dart';
import 'requested_sections_service.dart';

/// The [RequestedSectionsComponent] class...
@Component(
  selector: 'requested-sections',
  templateUrl: 'requested_sections_component.html',
  styleUrls: const ['requested_sections_component.css'],
  directives: const [
    MaterialExpansionPanel, MaterialIconComponent, NgIf, NgFor,
    RequestedSectionComponent
  ],
  providers: const [RequestedSectionsService]
)
class RequestedSectionsComponent implements OnInit {
  List<Section> sections;

  final RequestedSectionsService _reqSectionsService;

  /// The [RequestedSectionsComponent] constructor...
  RequestedSectionsComponent (this._reqSectionsService) {
    sections = new List<Section>();
  }

  /// The [ngOnInit] method...
  void ngOnInit() => (sections = _reqSectionsService.requestedSections);
}
