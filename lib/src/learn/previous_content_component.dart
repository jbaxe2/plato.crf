library plato.angular.components.learn.previous_content;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../banner/section.dart';

import 'enrollment.dart';
import 'enrollments_service.dart';
import 'previous_content_service.dart';

/// The [PreviousContentComponent] class...
@Component(
  selector: 'previous-content',
  templateUrl: 'previous_content_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [PreviousContentService]
)
class PreviousContentComponent implements OnInit {
  List<Enrollment> enrollments;

  final PreviousContentService _previousContentService;

  final EnrollmentsService _enrollmentsService;

  /// The [PreviousContentComponent] constructor...
  PreviousContentComponent (this._previousContentService, this._enrollmentsService) {
    enrollments = new List<Enrollment>();
  }

  /// The [ngOnInit] method...
  void ngOnInit() {
    enrollments = _enrollmentsService.enrollments;

    _previousContentService.sectionsStreamer.stream.listen (
      (Section section) {
        ;
      }
    );
  }
}
