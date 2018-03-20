library plato.angular.components.terms;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../courses/courses_service.dart';

import '../sections/sections_service.dart';

import 'term.dart';
import 'terms_service.dart';

/// The [TermsComponent] component class...
@Component(
  selector: 'terms',
  templateUrl: 'terms_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [TermsService, CoursesService, SectionsService],
)
class TermsComponent implements OnInit {
  List<Term> terms;

  Term selectedTerm;

  final TermsService termsService;

  final CoursesService coursesService;

  final SectionsService sectionsService;

  String selectorText;

  /// The [TermsComponent] constructor...
  TermsComponent (this.termsService, this.coursesService, this.sectionsService) {
    terms = new List<Term>();
    selectorText = 'Select a term...';
  }

  /// The [ngOnInit] method...
  @override
  Future ngOnInit() async {
    await termsService.retrieveTerms();

    terms = termsService.terms;
  }

  /// The [onTermSelected] method...
  void onTermSelected (Term aTerm) {
    selectedTerm = aTerm;
    selectorText = selectedTerm.description;

    coursesService.setTermId (selectedTerm.id);
    sectionsService.setTermId (selectedTerm.id);
  }
}
