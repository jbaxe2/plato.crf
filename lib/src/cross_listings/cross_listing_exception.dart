library plato.angular.exceptions.cross_listing;

import '../_application/error/plato_exception.dart';

/// The [CrossListingException] class...
class CrossListingException extends PlatoException {
  /// The [CrossListingException] constructor...
  CrossListingException (
    [message = 'A general cross-listing exception has occurred; no details were provided.']
  ) : super (message);
}
