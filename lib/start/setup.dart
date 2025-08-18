import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}