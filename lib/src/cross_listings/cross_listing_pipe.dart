library plato.crf.pipes.cross_listing;

import 'package:angular/angular.dart' show Pipe, PipeTransform;

import '../sections/section.dart';

import 'cross_listing.dart';

/// The [CrossListingPipe] class...
@Pipe('crossListingPipe', pure: false)
class CrossListingPipe implements PipeTransform {
  /// The [transform] method...
  String transform (CrossListing crossListing) {
    String sectionIds = '';

    crossListing.sections.forEach ((Section section) {
      if (sectionIds.isNotEmpty) {
        sectionIds += ' - ';
      }

      sectionIds += section.sectionId;
    });

    return sectionIds;
  }
}
