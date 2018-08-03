library plato.crf.components.application.directions;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

/// The [DirectionsComponent] class...
@Component(
  selector: 'directions',
  templateUrl: 'directions_component.html',
  styleUrls: const ['directions_component.scss.css'],
  directives: const [MaterialExpansionPanel]
)
class DirectionsComponent {
  /// The [DirectionsComponent] constructor...
  DirectionsComponent();
}
