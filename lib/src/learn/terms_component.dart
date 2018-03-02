library plato.angular.components.banner.terms;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'term.dart';

import 'terms_service.dart';

/// The [TermsComponent] component class...
@Component(
  selector: 'terms',
  templateUrl: 'terms_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [TermsService],
)
class TermsComponent implements OnInit {
  List<Term> terms;

  Term selectedTerm;

  final TermsService termsService;

  /// The [TermsComponent] constructor...
  TermsComponent (this.termsService) {
    terms = new List<Term>();
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
  }
}
