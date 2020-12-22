library plato.crf.components.sections.selection;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../requested/requested_sections_service.dart';

import '../section.dart';
import '../sections_service.dart';

/// The [SectionsSelectionComponent] class...
@Component(
  selector: 'sections-selection',
  templateUrl: 'sections_selection_component.html',
  styleUrls: ['sections_selection_component.css'],
  directives: [
    MaterialCheckboxComponent, MaterialButtonComponent, MaterialIconComponent,
    NgIf, NgFor
  ],
  providers: [SectionsService, RequestedSectionsService]
)
class SectionsSelectionComponent implements OnInit {
  List<Section> sections;

  List<Section> selectedSections;

  bool get haveSections => sections.isNotEmpty;

  final SectionsService _sectionsService;

  final RequestedSectionsService _reqSectionsService;

  /// The [SectionsSelectionComponent] constructor...
  SectionsSelectionComponent (this._sectionsService, this._reqSectionsService) {
    sections = <Section>[];
    selectedSections = <Section>[];
  }

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (sections = _sectionsService.sections);

  /// The [handleSectionSelection] method...
  void handleSectionSelection (Section section, bool checked) {
    if (checked && !selectedSections.contains (section)) {
      selectedSections.add (section);
    } else {
      selectedSections.remove (section);
    }
  }

  /// The [addSelectedSections] method...
  void addSelectedSections() {
    var addableSections = <Section>[];

    selectedSections.forEach ((Section section) {
      if (sections.contains (section)) {
        addableSections.add (section);
      }
    });

    _reqSectionsService.addSections (addableSections);
  }
}
