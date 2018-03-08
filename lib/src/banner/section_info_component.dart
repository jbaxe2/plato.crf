library plato.angular.components.section.info;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'section.dart';
import 'sections_service.dart';

/// The [SectionInfoComponent] class...
@Component(
  selector: 'section-info',
  templateUrl: 'section_info_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, DeferredContentDirective],
  providers: const [SectionsService]
)
class SectionInfoComponent implements OnInit {
  Section section;

  bool _hasCrossListing;

  bool get hasCrossListing => _hasCrossListing;

  bool _hasPreviousContent;

  bool get hasPreviousContent => _hasPreviousContent;

  bool get hasExtraInfo => (hasCrossListing || hasPreviousContent);

  final SectionsService sectionsService;

  /// The [SectionInfoComponent] constructor...
  SectionInfoComponent (this.sectionsService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    _hasCrossListing = false;
    _hasPreviousContent = false;
  }
}
