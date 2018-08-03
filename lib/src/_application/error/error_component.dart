library plato.crf.components.application.error;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'error_service.dart';
import 'plato_exception.dart';

/// The [ErrorComponent] class...
@Component(
  selector: 'plato-error',
  templateUrl: 'error_component.html',
  styleUrls: const ['error_component.scss.css'],
  directives: const [
    ModalComponent, MaterialDialogComponent, MaterialIconComponent,
    MaterialButtonComponent
  ],
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
    error = 'No errors have occurred.';
    showError = _errorService.errorRaised;

    _errorService.errorStreamController.stream.listen (
      (PlatoException exception) {
        error = exception.toString();
        showError = true;
      }
    );
  }
}
