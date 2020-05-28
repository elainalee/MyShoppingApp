import 'package:flutter/material.dart';
import 'package:ldp/ldp_launcher.dart';


class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/ldp_launcher': return MaterialPageRoute(builder: (_) => LdpLauncher(userViewModel: args));

      default: return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return
        Scaffold(
        body: Center(
          child: Text('ERROR PAGE; Please check the navigation route again'),
        ),
      );
    });
  }

}