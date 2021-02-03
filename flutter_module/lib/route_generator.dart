import 'package:flutter/material.dart';
import 'package:ldp/ldp_screen.dart';


class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      // this case requires args to be UserViewModel
//      case '/ldp_screen': return MaterialPageRoute(builder: (_) => LdpScreen(userViewModel: args));

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