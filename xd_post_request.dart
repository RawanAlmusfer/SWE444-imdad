import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDPostRequest extends StatelessWidget {
  XDPostRequest({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdda78d),
      body: Stack(
        children: <Widget>[
          Container(),
          Container(),
          Pinned.fromPins(
            Pin(size: 178.0, middle: 0.5),
            Pin(size: 34.0, start: 149.5),
            child: Text(
              'إضافة طلب جديد',
              style: TextStyle(
                fontFamily: 'Europa',
                fontSize: 25,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 23.3, end: 23.3),
            Pin(size: 305.2, middle: 0.3551),
            child:
                // Adobe XD layer: 'card_request1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'card' (shape)
                      SvgPicture.string(
                    _svg_pftscd,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 66.0, end: 23.8),
                  Pin(size: 20.0, start: 29.5),
                  child: Text(
                    'نوع الطلب',
                    style: TextStyle(
                      fontFamily: 'Europa-Regular',
                      fontSize: 15,
                      color: const Color(0xff334856),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 198.0, start: 29.8),
                  Pin(size: 28.0, start: 25.5),
                  child:
                      // Adobe XD layer: 'dropdown list' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: const Color(0xfff0f0f0),
                            border: Border.all(
                                width: 0.5, color: const Color(0xffdfdfdf)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 15.5, end: 15.7),
                        Pin(start: 6.2, end: 6.3),
                        child:
                            // Adobe XD layer: 'Icon ionic-ios-arro…' (shape)
                            SvgPicture.string(
                          _svg_jvl506,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 80.0, end: 23.8),
                  Pin(size: 20.0, middle: 0.2859),
                  child: Text(
                    'عنوان الطلب',
                    style: TextStyle(
                      fontFamily: 'Europa-Regular',
                      fontSize: 15,
                      color: const Color(0xff334856),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 90.0, end: 23.8),
                  Pin(size: 20.0, middle: 0.4682),
                  child: Text(
                    'تفاصيل الطلب',
                    style: TextStyle(
                      fontFamily: 'Europa-Regular',
                      fontSize: 15,
                      color: const Color(0xff334856),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 198.0, start: 29.8),
                  Pin(size: 28.0, middle: 0.2797),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 0.5, color: const Color(0xffdfdfdf)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 56.0, middle: 0.5),
                  Pin(size: 20.0, middle: 0.5839),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Europa',
                        fontSize: 15,
                        color: const Color(0xffd97d54),
                      ),
                      children: [
                        TextSpan(
                          text: 'المبلغ:  ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: 'ت',
                          style: TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 146.0, start: 29.8),
                  Pin(size: 28.0, middle: 0.59),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 0.5, color: const Color(0xffdfdfdf)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 20.0, start: 42.8),
                  Pin(size: 15.0, middle: 0.5808),
                  child: Text(
                    'ريال',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 11,
                      color: const Color(0xffd2d2d2),
                      fontWeight: FontWeight.w700,
                    ),
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

const String _svg_pftscd =
    '<svg viewBox="0.3 9.0 381.5 305.2" ><defs><filter id="shadow"><feDropShadow dx="0" dy="5" stdDeviation="10"/></filter></defs><path transform="translate(0.25, 9.0)" d="M 16.93047332763672 0 L 364.5695190429688 0 C 373.9199829101562 0 381.5 6.715729713439941 381.5 15 L 381.5 290.19921875 C 381.5 298.4834899902344 373.9199829101562 305.19921875 364.5695190429688 305.19921875 L 16.93047332763672 305.19921875 C 7.580032348632812 305.19921875 0 298.4834899902344 0 290.19921875 L 0 15 C 0 6.715729713439941 7.580032348632812 0 16.93047332763672 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_jvl506 =
    '<svg viewBox="330.8 40.7 15.5 15.5" ><path transform="translate(327.45, 37.37)" d="M 3.375 11.1160888671875 C 3.375 15.39229583740234 6.839881896972656 18.857177734375 11.1160888671875 18.857177734375 C 15.39229583740234 18.857177734375 18.857177734375 15.39229583740234 18.857177734375 11.1160888671875 C 18.857177734375 6.839881896972656 15.39229583740234 3.375 11.1160888671875 3.375 C 6.839881420135498 3.375 3.375 6.839881896972656 3.375 11.1160888671875 Z M 14.13436889648438 9.500881195068359 C 14.41349411010742 9.221755027770996 14.87126159667969 9.221755027770996 15.15038681030273 9.500881195068359 C 15.29180908203125 9.642305374145508 15.35880088806152 9.824666976928711 15.35880088806152 10.00702857971191 C 15.35880088806152 10.18939208984375 15.28808784484863 10.37547492980957 15.14666366577148 10.51689910888672 L 11.63712310791016 14.0152759552002 C 11.35427474975586 14.27207183837891 10.91883850097656 14.26462936401367 10.64715766906738 13.99294662475586 L 7.085511684417725 10.44246482849121 C 6.806385517120361 10.16333961486816 6.802663803100586 9.709295272827148 7.085511684417725 9.426447868347168 C 7.36463737487793 9.147321701049805 7.818682193756104 9.143600463867188 8.101529121398926 9.426447868347168 L 11.11981010437012 12.47450065612793 L 14.13436889648438 9.500881195068359 Z" fill="#d97d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
