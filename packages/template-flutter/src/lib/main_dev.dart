import 'package:flutter/material.dart';
import 'package:template/main.dart';

import 'config/env/dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await env.init();
  runApp(const App());
}
