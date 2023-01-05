import 'package:flutter/material.dart';
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

class Navigation {

  static back(BuildContext context) {
    Navigator.pop(context);
  }

  static intent(BuildContext context, String nameRouted) {
    Navigator.pushNamed(context, nameRouted);
  }

  static intentWithoutBack(BuildContext context, String nameRouted) {
    Navigator.pushReplacementNamed(context, nameRouted);
  }

  static intentWithClearAllRoutes(BuildContext context, String nameRouted) {
    Navigator.of(context).pushNamedAndRemoveUntil(nameRouted, (Route<dynamic> route) => false);
  }

  static intentWithData(BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushNamed(
        context,
        nameRouted,
        arguments: argumentClass
    );
  }


  static pushScreen(BuildContext context, Widget screen) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: screen,
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

}