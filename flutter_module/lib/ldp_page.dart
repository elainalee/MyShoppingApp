import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldp/ldp_card.dart';
import 'package:ldp/ldp_extension.dart';
import 'package:ldp/user_view_model.dart';

import 'constants.dart';

class LdpPage extends StatefulWidget {

  @override
  _LdpPageState createState() => _LdpPageState();
}

class _LdpPageState extends State<LdpPage> {

//  String _username = 'Unknown';
//  String _password = 'Unknown';
  UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {

    _getUserInfo();
//    List<Widget> _listingCards = LdpExtension().listingCards;

    return Scaffold(
      appBar: AppBar(
        title: Text("To be implemented"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          <Widget>[
            LdpCard(userViewModel: userViewModel),
            Text(
              'The username requested is:',
            ),
//            Text(
//              _username,
//              style: Theme.of(context).textTheme.headline4,
//            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/ldp_launcher',
            arguments: userViewModel ,
          );
        },
//        _getUsername,
        tooltip: 'Username',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getUserInfo() async {
    String requestedUsername, requestedPassword;
    try {
      requestedUsername = await CHANNEL.invokeMethod("getUsername");
      requestedPassword = await CHANNEL.invokeMethod("getPassword");
    } on PlatformException catch (e) {
      requestedUsername = "Failed to get username: '${e.message}";
      requestedPassword = "Failed to get password: '${e.message}";
    }
    setState(() {
//      _username = requestedUsername;
//      _password = requestedPassword;
      userViewModel = UserViewModel(username: requestedUsername, password: requestedPassword);
    });
  }
}
