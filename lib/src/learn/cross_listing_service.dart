library plato.angular.services.learn.cross_listing;

import 'dart:async' show Stream, StreamController;

import 'package:angular/angular.dart';
import 'package:angular/core.dart';

import 'package:angular_components/angular_components.dart'
  show DeferredContentAware;

import '../banner/section.dart';

import '../crf/request_information.dart';

import 'cross_listing.dart';

/// The [CrossListingService] class...
@Injectable()
class CrossListingService implements DeferredContentAware {
  List<CrossListing> crossListings;

  Map<Section, CrossListing> crossListedSections;

  StreamController<Section> sectionStreamer;

  StreamController<bool> invokerStreamer;

  RequestInformation _requestInformation;

  static CrossListingService _instance;

  Stream<bool> get contentVisible => invokerStreamer.stream;

  /// The [CrossListingService] factory constructor...
  factory CrossListingService() =>
    _instance ?? (_instance = new CrossListingService._());

  /// The [CrossListingService] private constructor...
  CrossListingService._() {
    _requestInformation = new RequestInformation();
    crossListings = _requestInformation.crossListings;

    sectionStreamer = new StreamController<Section>.broadcast();
    invokerStreamer = new StreamController<bool>.broadcast();
  }

  /// The [createCrossListingSet] method...
  CrossListing createCrossListingSet() {
    var crossListing = new CrossListing();

    try {
      _requestInformation.addCrossListing (crossListing);
    } catch (_) { rethrow; }

    return crossListing;
  }

  /// The [invokeForSection] method...
  void invokeForSection (Section section) {
    sectionStreamer.add (section);
    invokerStreamer.add (true);
  }

  /// The [revokeSection] method...
  void revokeSection() {
    sectionStreamer.add (null);
    invokerStreamer.add (false);
  }

  /// The [addCrossListings] method...
  void addCrossListings (List<CrossListing> crossListings) =>
    _requestInformation.addCrossListings (crossListings);

  /// The [removeCrossListing] method...
  bool removeCrossListing (CrossListing crossListing) =>
    _requestInformation.removeCrossListing (crossListing);

  /// The [addSectionToCrossListing] method...
  void addSectionToCrossListing (Section theSection, CrossListing theCrossListing) {
    try {
      _requestInformation.addSectionToCrossListing (theSection, theCrossListing);
      crossListedSections.putIfAbsent (theSection, () => theCrossListing);
    } catch (_) { rethrow; }
  }

  /// The [removeSectionFromCrossListing] method...
  void removeSectionFromCrossListing (Section theSection, CrossListing theCrossListing) {
    try {
      _requestInformation.removeSectionFromCrossListing (theSection, theCrossListing);
      crossListedSections.remove (theSection);
    } catch (_) { rethrow; }
  }
}
