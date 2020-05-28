import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const CHANNEL = const MethodChannel("my_app/request2");

void secondMain() {

  runApp(Container(color: Colors.red));
  CHANNEL.setMethodCallHandler((MethodCall call) async {
    // no-op
  });
}



class LdpPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ldp Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
        title: Text(widget.title),
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
