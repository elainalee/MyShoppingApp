import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/route_generator.dart';
import 'package:ldp/common/ldp_theme.dart';
import 'package:ldp/main.dart';

import 'lead_to_ldp.dart';
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
      theme: buildLdpTheme(context),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      routes: {
        '/': (context) => Container(
            child: Text(
                "This is not the correct route. Please register the route.")),
        '/lead_to_ldp': (context) => LeadToLDP(),
      },
    );
  }
}
