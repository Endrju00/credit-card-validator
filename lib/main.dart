import 'package:flutter/material.dart';

import 'src/injection_container.dart' as di;
import 'src/app.dart';

void main() {
  di.setUp();
  runApp(const MyApp());
}
