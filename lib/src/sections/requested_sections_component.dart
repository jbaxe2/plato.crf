library plato.angular.components.crf.sections.requested;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato_angular/src/sections/section.dart';

import 'package:plato_angular/src/sections/requested_section_component.dart';
import 'package:plato_angular/src/sections/requested_sections_service.dart';

/// The [RequestedSectionsComponent] class...
@Component(
  selector: 'requested-sections',
  templateUrl: 'requested_sections_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, RequestedSectionComponent],
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
  void ngOnInit() {
    sections = _reqSectionsService.requestedSections;
  }
}
