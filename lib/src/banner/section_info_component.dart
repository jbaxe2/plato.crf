library plato.angular.components.banner.section.info;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../crf/requested_sections_service.dart';

import 'section.dart';

/// The [SectionInfoComponent] class...
@Component(
  selector: 'section-info',
  templateUrl: 'section_info_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [RequestedSectionsService]
)
class SectionInfoComponent implements OnInit {
  @Input()
  Section section;

  bool _hasCrossListing;

  bool get hasCrossListing => _hasCrossListing;

  bool _hasPreviousContent;

  bool get hasPreviousContent => _hasPreviousContent;

  bool get hasExtraInfo => (hasCrossListing || hasPreviousContent);

  final RequestedSectionsService _reqSectionsService;

  /// The [SectionInfoComponent] constructor...
  SectionInfoComponent (this._reqSectionsService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _hasCrossListing = false;
    _hasPreviousContent = false;
  }
}
