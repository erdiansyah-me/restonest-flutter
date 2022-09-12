import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restonest/provider/detail_provider.dart';

final GlobalKey<NavigatorState> navigatorGlobalKey =
    GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, String args) {
    var context = navigatorGlobalKey.currentContext;
    context!.read<DetailProvider>().idResto = args;
    navigatorGlobalKey.currentState?.pushNamed(routeName, arguments: args);
  }

  static back() => navigatorGlobalKey.currentState?.pop();
}
