// Copyright (c) 2017, jbaxe2. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library plato.angular;

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';

import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'package:plato_angular/course_request.dart';

/// The [main] function...
void main() {
  bootstrap (CourseRequest, [
    provide (Client, useFactory: () => new BrowserClient(), deps: [])
  ]);
}
