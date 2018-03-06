library plato.angular.components.section.info;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'section.dart';
import 'sections_service.dart';

/// The [SectionInfoComponent] class...
@Component(
  selector: 'section-info',
  templateUrl: 'section_info_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [SectionsService]
)
class SectionInfoComponent {
  Section section;

  final SectionsService sectionsService;

  /// The [SectionInfoComponent] constructor...
  SectionInfoComponent (this.sectionsService);
}
