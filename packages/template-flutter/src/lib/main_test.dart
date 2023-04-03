import 'package:flutter/material.dart';
import 'package:template/main.dart';

import 'config/env/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await env.init();
  runApp(const App());
}
