library plato.crf.services.sections.requested;

import 'package:angular/core.dart';

import '../../course_request/course_request.dart';

import '../section.dart';

/// The [RequestedSectionsService] class...
@Injectable()
class RequestedSectionsService {
  List<Section> requestedSections;

  CourseRequest _courseRequest;

  static RequestedSectionsService _instance;

  /// The [RequestedSectionsService] factory constructor...
  factory RequestedSectionsService() =>
    _instance ?? (_instance = new RequestedSectionsService._());

  /// The [RequestedSectionsService] private constructor...
  RequestedSectionsService._() {
    _courseRequest = new CourseRequest();
    requestedSections = _courseRequest.sections;
  }

  /// The [addSections] method...
  void addSections (List<Section> sections) {
    sections.sort();

    _courseRequest.addSections (sections);
  }

  /// The [addSection] method...
  void addSection (Section section) => _courseRequest.addSection (section);

  /// The [removeSection] method...
  bool removeSection (Section section) => _courseRequest.removeSection (section);
}
