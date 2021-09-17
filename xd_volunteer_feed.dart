import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './xd_card_chris.dart';

class XDVolunteerFeed extends StatelessWidget {
  XDVolunteerFeed({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffb5b5b4),
      body: Stack(
        children: <Widget>[
          Container(),
          Pinned.fromPins(
            Pin(start: 23.3, end: 23.3),
            Pin(size: 168.4, start: 91.9),
            child:
                // Adobe XD layer: 'card_chris' (component)
                XDCardChris(),
          ),
          Container(),
          Pinned.fromPins(
            Pin(start: 23.3, end: 23.3),
            Pin(size: 168.4, middle: 0.3589),
            child:
                // Adobe XD layer: 'card_chris' (component)
                XDCardChris(),
          ),
          Pinned.fromPins(
            Pin(start: 23.3, end: 23.3),
            Pin(size: 168.4, middle: 0.5965),
            child:
                // Adobe XD layer: 'card_chris' (component)
                XDCardChris(),
          ),
          Pinned.fromPins(
            Pin(start: 23.3, end: 23.3),
            Pin(size: 168.4, end: 125.7),
            child:
                // Adobe XD layer: 'card_chris' (component)
                XDCardChris(),
          ),
        ],
      ),
    );
  }
}
