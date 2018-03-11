library plato.angular.components.banner.section.info;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../banner/section.dart';

import 'requested_sections_service.dart';

/// The [RequestedSectionComponent] class...
@Component(
  selector: 'requested-section',
  templateUrl: 'requested-section_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [RequestedSectionsService]
)
class RequestedSectionComponent implements OnInit {
  @Input()
  Section section;

  bool _hasCrossListing;

  bool get hasCrossListing => _hasCrossListing;

  bool _hasPreviousContent;

  bool get hasPreviousContent => _hasPreviousContent;

  bool get hasExtraInfo => (hasCrossListing || hasPreviousContent);

  final RequestedSectionsService _reqSectionsService;

  /// The [RequestedSectionComponent] constructor...
  RequestedSectionComponent (this._reqSectionsService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _hasCrossListing = false;
    _hasPreviousContent = false;
  }
}
