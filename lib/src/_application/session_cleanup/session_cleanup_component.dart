library plato.crf.components.cleanup.session;

import 'dart:async' show Future;
import 'dart:html' show window;

import 'package:http/http.dart' show Client;

import 'package:angular/angular.dart';

const String _CLEANUP_URI = '/plato/cleanup/session';

/// The [SessionCleanupComponent] class...
@Component(
  selector: 'session-cleanup',
  template: ''
)
class SessionCleanupComponent implements OnInit {
  final Client _http;

  static bool _sentCleanupSignal;

  /// The [SessionCleanupComponent] constructor...
  SessionCleanupComponent (this._http);

  /// The [ngOnInit] method...
  @override
  Future<void> ngOnInit() async {
    _sentCleanupSignal = false;

    window.onBeforeUnload.listen ((_) async => await _sendCleanup());

    window.onUnload.listen ((_) async {
      if (!_sentCleanupSignal) {
        await _sendCleanup();
      }
    });
  }

  /// The [_sendCleanup] method...
  Future<void> _sendCleanup() async {
    await _http.get (_CLEANUP_URI);

    _sentCleanupSignal = true;
  }
}
