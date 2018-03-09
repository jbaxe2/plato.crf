library plato.angular.components.banner.sections.selection;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../crf/requested_sections_service.dart';

import 'section.dart';
import 'sections_service.dart';

/// The [SectionsSelectionComponent] class...
@Component(
  selector: 'sections-selection',
  templateUrl: 'sections_selection_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [SectionsService, RequestedSectionsService]
)
class SectionsSelectionComponent implements OnInit {
  List<Section> sections;

  List<Section> selectedSections;

  bool get haveSections => sections.isNotEmpty;

  final SectionsService _sectionsService;

  final RequestedSectionsService _reqSectionsService;

  /// The [SectionsSelectionComponent] constructor...
  SectionsSelectionComponent (this._sectionsService, this._reqSectionsService) {
    sections = new List<Section>();
    selectedSections = new List<Section>();
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (sections = _sectionsService.sections);

  /// The [handleSectionSelection] method...
  void handleSectionSelection (Section section, bool checked) {
    if (checked && !selectedSections.contains (section)) {
      selectedSections.add (section);
    }

    if (!checked && selectedSections.contains (section)) {
      selectedSections.removeWhere ((Section aSection) => (section == aSection));
    }
  }

  /// The [addSelectedSections] method...
  void addSelectedSections() => _reqSectionsService.addSections (selectedSections);
}
