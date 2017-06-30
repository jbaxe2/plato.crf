library plato.angular.components.banner.terms;

import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import 'terms_service.dart';
import 'term.dart';

/// The [TermsComponent] class...
@Component(
  selector: 'terms',
  styleUrls: const ['terms_component.css'],
  templateUrl: 'terms_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [TermsService],
)
class TermsComponent implements OnInit {
  final TermsService termsService;

  List<Term> terms;

  TermsComponent (this.termsService);

  @override
  Future ngOnInit() async {
    terms = await termsService.loadTerms();
  }
}
