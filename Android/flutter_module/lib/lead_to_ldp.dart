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
  String listingID;

  @override
  Widget build(BuildContext context) {
    _getUserInfo();
//    List<Widget> _listingCards = LdpExtension().listingCards;
    return LdpScreen(userViewModel: userViewModel ?? null, listingID: listingID ?? null);
  }

  Future<void> _getUserInfo() async {
    String requestedUsername, requestedPassword, requestedListingID;
    try {
      requestedUsername = await CHANNEL.invokeMethod("getUsername");
      requestedPassword = await CHANNEL.invokeMethod("getPassword");
      requestedListingID = await CHANNEL.invokeMethod("getListingID");
    } on PlatformException catch (e) {
      requestedUsername = "Failed to get username: '${e.message}";
      requestedPassword = "Failed to get password: '${e.message}";
      requestedListingID = "Failed to get ListingID: '${e.message}";
    }
    setState(() {
      userViewModel = UserViewModel(username: requestedUsername, password: requestedPassword);
      listingID = requestedListingID;
    });
  }
}
