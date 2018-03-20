library plato.angular.components.application.error;

import 'dart:async' show Stream;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato_angular/src/_application/error/error_service.dart';
import 'package:plato_angular/src/_application/error/plato_exception.dart';

/// The [ErrorComponent] class...
@Component(
  selector: 'plato-error',
  templateUrl: 'error_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders, ErrorService]
)
class ErrorComponent implements OnInit {
  Stream<PlatoException> errorStream;

  String error;

  bool showError;

  final ErrorService _errorService;

  /// The [ErrorComponent] constructor...
  ErrorComponent (this._errorService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {
    showError = _errorService.errorRaised;
    error = 'No errors have occurred.';

    errorStream = _errorService.errorStreamController.stream;

    errorStream.listen (
      (PlatoException exception) {
        error = exception.toString();
        showError = true;
      }
    );
  }
}
