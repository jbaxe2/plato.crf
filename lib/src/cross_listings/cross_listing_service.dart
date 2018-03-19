library plato.angular.services.learn.cross_listing;

import 'dart:async' show StreamController;

import 'package:angular/angular.dart';
import 'package:angular/core.dart';

import '../crf/extra_info_service.dart';
import '../crf/request_information.dart';

import '../sections/section.dart';

import 'cross_listing.dart';
import 'cross_listing_exception.dart';

/// The [CrossListingService] class...
@Injectable()
class CrossListingService extends ExtraInfoService {
  List<CrossListing> crossListings;

  StreamController<CrossListing> crossListingStreamer;

  RequestInformation _requestInformation;

  static CrossListingService _instance;

  /// The [CrossListingService] factory constructor...
  factory CrossListingService() =>
    _instance ?? (_instance = new CrossListingService._());

  /// The [CrossListingService] private constructor...
  CrossListingService._() {
    _requestInformation = new RequestInformation();

    crossListings = _requestInformation.crossListings;
    crossListingStreamer = new StreamController<CrossListing>.broadcast();

    init();
  }

  /// The [createCrossListingSet] method...
  CrossListing createCrossListingSet() {
    var crossListing = new CrossListing();

    try {
      _requestInformation.addCrossListing (crossListing);
    } catch (_) { rethrow; }

    return crossListing;
  }

  /// The [revokeSection] method...
  void revokeSection() {
    //sectionStreamer.add (null);
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
    } catch (_) { rethrow; }
  }

  /// The [removeSectionFromCrossListing] method...
  void removeSectionFromCrossListing (Section theSection, CrossListing theCrossListing) {
    try {
      _requestInformation.removeSectionFromCrossListing (theSection, theCrossListing);
    } catch (_) { rethrow; }
  }

  /// The [confirmCrossListings] method...
  void confirmCrossListings() {
    if (
      crossListings.any ((CrossListing crossListing) => crossListing.sections.isEmpty)
    ) {
      throw new CrossListingException (
        'Cannot confirm cross-listings when one or more sets is empty.'
      );
    }

    if (crossListings.isEmpty) {
      crossListingStreamer.add (null);

      return;
    }

    crossListings.forEach (
      (CrossListing aCrossListing) => crossListingStreamer.add (aCrossListing)
    );
  }
}
