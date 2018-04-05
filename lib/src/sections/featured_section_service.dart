library plato.angular.services.sections.featured;

import 'dart:async' show StreamController;

import 'section.dart';

/// The [FeaturedSectionService] class...
abstract class FeaturedSectionService {
  /// A [StreamController] that will add instances of [Section] to a stream.
  /// Note that it is imperative that each subclass (representing a service for
  /// some type of extra info) must have its own instance of the stream
  /// controller.  Otherwise multiple services will receive the same
  /// notification a section has been added for a particular service.
  StreamController<Section> sectionsStreamer;

  /// The [init] method...
  void init() {
    if (null == sectionsStreamer) {
      sectionsStreamer = new StreamController<Section>.broadcast();
    }
  }

  /// The [invokeForSection] method...
  void invokeForSection (Section section) {
    sectionsStreamer.add (section);
  }

  /// The [revokeSection] method...
  void revokeSection();
}
