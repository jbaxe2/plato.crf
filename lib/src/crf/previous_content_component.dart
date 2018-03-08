library plato.angular.components.crf.previous_content;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'previous_content_service.dart';

/// The [PreviousContentComponent] class...
@Component(
  selector: 'previous-content',
  templateUrl: 'previous_content_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [PreviousContentService]
)
class PreviousContentComponent {
  final PreviousContentService _previousContentService;

  /// The [PreviousContentComponent] constructor...
  PreviousContentComponent (this._previousContentService);
}
