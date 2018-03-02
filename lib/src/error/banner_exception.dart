library plato.angular.exceptions.banner;

import 'plato_exception.dart';

/// The [BannerException] class...
class BannerException extends PlatoException {
  /// The [BannerException] constructor...
  BannerException (
    [message = 'A general Banner exception has occurred; no details were provided.']
  ) : super (message);
}
