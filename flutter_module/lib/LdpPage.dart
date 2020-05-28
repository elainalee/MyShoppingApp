import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class LdpPage extends StatefulWidget {

  @override
  _LdpPageState createState() => _LdpPageState();
}

class _LdpPageState extends State<LdpPage> {

  String _username = 'Unknown';

  Future<void> _getUsername() async {
    String username;
    try {
      final String result = await CHANNEL.invokeMethod("getUsername");
      username = result;
    } on PlatformException catch (e) {
      username = "Failed to get username: '${e.message}";
    }
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To be implemented"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'The username requested is:',
            ),
            Text(
              _username,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUsername,
        tooltip: 'Username',
        child: Icon(Icons.add),
      ),
    );
  }
}
