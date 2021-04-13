import 'package:flutter/cupertino.dart';

import 'desktop_navbar.dart';
import 'mobile_navbar.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth > 1200) {
        return DesktopNavBar();
      } else if (constrains.maxWidth > 800 && constrains.maxWidth < 1200) {
        return DesktopNavBar();
      } else {
        return MobileNavBar();
      }
    });
  }
}
