library plato.angular.components.crf.error;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart/';

import 'error_service.dart';

/// The [ErrorComponent] class...
@Component(
  selector: 'error',
  templateUrl: 'error_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [ErrorService]
)
class ErrorComponent implements OnInit {
  String error;

  bool showError;

  final ErrorService _errorService;

  /// The [ErrorComponent] constructor...
  ErrorComponent (this._errorService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    error = _errorService.exception.message;
    showError = _errorService.errorRaised;
  }

  /// The [closeError] method...
  void closeError() => (showError = false);
}
