library plato.angular.services.progress;

import 'dart:async' show StreamController;

import 'package:angular/core.dart';

/// The [ProgressService] class...
@Injectable()
class ProgressService {
  StreamController<String> messageStreamController;

  static ProgressService _instance;

  /// The [ProgressService] factory constructor...
  factory ProgressService() =>
    _instance ?? (_instance = new ProgressService._());

  /// The [ProgressService] private constructor...
  ProgressService._() {
    messageStreamController = new StreamController<String>.broadcast();
  }

  /// The [invokeProgress] method...
  void invokeProgress (String message) =>
    messageStreamController.add (
      message ?? '(Progress invoked with unkown message.)'
    );

  /// The [revokeProgress] method...
  void revokeProgress() => messageStreamController.add (null);
}
