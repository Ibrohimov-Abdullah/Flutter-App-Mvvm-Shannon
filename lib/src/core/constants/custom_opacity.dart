import 'package:flutter/cupertino.dart';

import '../style/app_text_styles.dart';

extension CustomColorOpacity on Color {
  Color customOpacity(double opacity) {
    return withAlpha((opacity * 255).toInt());
  }
}

AppTextStyle style = const AppTextStyle();