library plato.crf.components.user.plato;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'plato_user.dart';
import 'plato_user_service.dart';

/// The [PlatoUserComponent] class...
@Component(
  selector: 'plato-user',
  templateUrl: 'plato_user_component.html',
  directives: const [coreDirectives, materialDirectives],
  providers: const [PlatoUserService]
)
class PlatoUserComponent implements OnInit {
  PlatoUser platoUser;

  final PlatoUserService _platoUserService;

  /// The [PlatoUserComponent] constructor...
  PlatoUserComponent (this._platoUserService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() => (platoUser = _platoUserService.platoUser);
}
