import "package:flutter/material.dart";

import "../src/core/widgets/custom_screen_util.dart";
import "app_material_context.dart";

class App extends StatelessWidget {
  const App({super.key});

  static void run() => runApp(const App());

  @override
  Widget build(BuildContext context) => const CustomScreenUtil(
    enabledPreview: false,
    child: AppMaterialContext(),
  );
}