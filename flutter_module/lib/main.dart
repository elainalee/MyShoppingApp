import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/router.dart';

import 'ldp_page.dart';
import 'constants.dart';

void main() {
  runApp(RegisteredPage());
  CHANNEL.setMethodCallHandler((MethodCall call) async {
    // no-op
  });
}

class RegisteredPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ldp Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page1'),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      routes: {
        '/': (context) => Container(
            child: Text(
                "This is not the correct route. Please register the route.")),
        '/ldp_page': (context) => LdpPage(),
      },
    );
  }
}
