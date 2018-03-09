library plato.angular.services.crf.requesting_sections;

import 'package:angular/core.dart';

import '../banner/section.dart';

import '../crf/request_information.dart';

/// The [RequestedSectionsService] class...
@Injectable()
class RequestedSectionsService {
  List<Section> requestedSections;

  RequestInformation _requestInformation;

  static RequestedSectionsService _instance;

  /// The [RequestedSectionsService] factory constructor...
  factory RequestedSectionsService() =>
    _instance ?? (_instance = new RequestedSectionsService._());

  /// The [RequestedSectionsService] private constructor...
  RequestedSectionsService._() {
    _requestInformation = new RequestInformation();
    requestedSections = _requestInformation.sections;
  }

  /// The [addSections] method...
  void addSections (List<Section> sections) => _requestInformation.addSections (sections);

  /// The [addSection] method...
  void addSection (Section section) => _requestInformation.addSection (section);

  /// The [removeSection] method...
  bool removeSection (Section section) => _requestInformation.removeSection (section);
}
