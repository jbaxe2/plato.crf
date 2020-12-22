library plato.crf.services.progress;

import 'dart:async' show StreamController;

/// The [ProgressService] class...
class ProgressService {
  StreamController<String> messageStreamController;

  static ProgressService _instance;

  /// The [ProgressService] factory constructor...
  factory ProgressService() =>
    _instance ?? (_instance = ProgressService._());

  /// The [ProgressService] private constructor...
  ProgressService._() {
    messageStreamController = StreamController<String>.broadcast();
  }

  /// The [invoke] method...
  void invoke (String message) => messageStreamController.add (
    message ?? '(Status indicator invoked with unkown message.)'
  );

  /// The [revoke] method...
  void revoke() => messageStreamController.add (null);
}
