library plato.angular.components.banner.sections.selection;

//import 'dart:async' show Future;
import 'dart:html' show window;

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

  /// The [handleSectionSelection] method...
  void handleSectionSelection (bool checked, Section section) {
    if (checked && !selectedSections.contains (section)) {
      selectedSections.add (section);
    }

    if (!checked && selectedSections.contains (section)) {
      selectedSections.removeWhere ((Section aSection) => (section == aSection));
    }
  }

  /// The [addSelectedSections] method...
  void addSelectedSections() {
    window.console.log ('There are ${selectedSections.length} selected sections.');

    selectedSections.forEach ((Section section) {
      window.console.log ('Section: ${section.courseId}');
    });
  }
}
