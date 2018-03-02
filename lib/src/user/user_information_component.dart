library plato.angular.components.user.information;

import 'dart:async' show Future;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'user_information.dart';

import 'user_information_service.dart';

/// The [UserInformationComponent] class...
@Component(
  selector: 'user-information',
  templateUrl: 'user_information_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [UserInformationService]
)
class UserInformationComponent implements OnInit {
  UserInformation userInformation;

  final UserInformationService userInfoService;

  /// The [UserInformationComponent] constructor...
  UserInformationComponent (this.userInfoService);

  /// The [ngOnInit] method...
  Future ngOnInit() async {
    await userInfoService.retrieveSession();
  }
}
