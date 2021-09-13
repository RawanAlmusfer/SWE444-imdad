import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class XDStartingScreen extends StatelessWidget {
  XDStartingScreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x85d66f3e),
      body: Stack(
        children: <Widget>[
          Container(),
          Pinned.fromPins(
            Pin(start: 45.0, end: 21.0),
            Pin(size: 228.0, middle: 0.3797),
            child:
                // Adobe XD layer: 'Picture1' (shape)
                Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(),
          Pinned.fromPins(
            Pin(start: 36.0, end: 36.0),
            Pin(size: 66.0, middle: 0.6977),
            child:
                // Adobe XD layer: 'large btn 1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xfffffbf4),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 112.0, end: 96.0),
                  Pin(size: 34.0, start: 12.0),
                  child: Text(
                    'مستخدم جديد ',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 25,
                      color: const Color(0xffd66f3e),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 36.0, end: 36.0),
            Pin(size: 66.0, middle: 0.7988),
            child:
                // Adobe XD layer: 'large btn 1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xfffffbf4),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 112.0, end: 112.0),
                  Pin(size: 34.0, start: 16.0),
                  child: Text(
                    'تسجيل دخول',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 25,
                      color: const Color(0xff4c4c4c),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
