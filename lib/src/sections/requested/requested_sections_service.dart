library plato.crf.services.sections.requested;

import 'dart:async' show Stream, StreamController;

import '../../course_request/course_request.dart';

import '../section.dart';

/// The [RequestedSectionsService] class...
class RequestedSectionsService {
  List<Section> requestedSections;

  CourseRequest _courseRequest;

  static final StreamController<bool> _haveSectionsController =
    new StreamController<bool>.broadcast();

  Stream<bool> get haveSectionsListener => _haveSectionsController.stream;

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
    _checkHaveSections();
  }

  /// The [removeSection] method...
  bool removeSection (Section section) {
    bool removed = _courseRequest.removeSection (section);
    _checkHaveSections();

    return removed;
  }

  /// The [_checkHaveSections] method...
  void _checkHaveSections() {
    _haveSectionsController.add (requestedSections.isNotEmpty);
  }
}
