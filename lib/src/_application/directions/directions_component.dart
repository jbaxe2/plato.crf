library plato.angular.components.application.directions;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

/// The [DirectionsComponent] class...
@Component(
  selector: 'directions',
  templateUrl: 'directions_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders]
)
class DirectionsComponent {
  /// The [DirectionsComponent] constructor...
  DirectionsComponent();
}
