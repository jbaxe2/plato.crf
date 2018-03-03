library plato.angular.components.banner.sections.selection;

//import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'section.dart';

import 'sections_service.dart';

/// The [SectionsSelectionComponent] class...
@Component(
  selector: 'sections-selection',
  templateUrl: 'sections_selection_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [SectionsService]
)
class SectionsSelectionComponent implements OnInit {
  List<Section> sections;

  List<Section> selectedSections;

  final SectionsService sectionsService;

  /// The [SectionsSelectionComponent] constructor...
  SectionsSelectionComponent (this.sectionsService) {
    sections = new List<Section>();
    selectedSections = new List<Section>();
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (sections = sectionsService.sections);
}
