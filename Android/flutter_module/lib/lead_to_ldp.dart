import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ldp_screen.dart';

import 'constants.dart';


class LeadToLDP extends StatefulWidget {

  @override
  _LeadToLDPState createState() => _LeadToLDPState();
}

class _LeadToLDPState extends State<LeadToLDP> {
  UserViewModel userViewModel;
  @override
  Widget build(BuildContext context) {
    _getUserInfo();
//    List<Widget> _listingCards = LdpExtension().listingCards;
    return LdpScreen(userViewModel: userViewModel ?? null);
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
