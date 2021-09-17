import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class XDLogin extends StatelessWidget {
  XDLogin({
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
            Pin(start: 33.0, end: 33.0),
            Pin(size: 252.0, start: 102.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 24.0),
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
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 36.0, end: 36.0),
            Pin(size: 66.0, middle: 0.493),
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
                      color: const Color(0x9dfffbf4),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 153.0, end: 31.0),
                  Pin(size: 34.0, start: 11.0),
                  child: Text(
                    'البريد الالكتروني ',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 25,
                      color: const Color(0x9db7aba4),
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
            Pin(size: 66.0, middle: 0.6023),
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
                      color: const Color(0x9efffbf4),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 189.0, end: 67.0),
                  Pin(size: 34.0, start: 11.0),
                  child: Text(
                    'كلمة السر',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 25,
                      color: const Color(0x9eb7aba4),
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
          Container(),
          Pinned.fromPins(
            Pin(size: 138.0, end: 49.0),
            Pin(size: 30.0, middle: 0.6641),
            child: Text(
              'نسيت كلمة السر؟',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 20,
                color: const Color(0xff6f625c),
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 165.0, end: 163.0),
            Pin(size: 40.0, start: 776.0),
            child: Text(
              'التسجيل',
              style: TextStyle(
                fontFamily: 'Bodoni 72 Oldstyle',
                fontSize: 30,
                color: const Color(0x824c4c4c),
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.underline,
                height: 1.0333333333333334,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 225.0, middle: 0.5025),
            Pin(size: 85.0, middle: 0.7919),
            child:
                // Adobe XD layer: 'large btn 1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33.0),
                      color: const Color(0xbdfffbf4),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 40.0, end: 43.0),
                  Pin(size: 33.0, start: 23.0),
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 24,
                      color: const Color(0xbd4c4c4c),
                      fontWeight: FontWeight.w700,
                      height: 1.4166666666666667,
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
