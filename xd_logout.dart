import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './xd_card_chris.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDLogout extends StatelessWidget {
  XDLogout({
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
            Pin(start: 32.3, end: 32.3),
            Pin(start: 82.9, end: 125.7),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'card_chris' (component)
                      XDCardChris(),
                ),
              ],
            ),
          ),
          Container(),
          Pinned.fromPins(
            Pin(start: 40.0, end: 234.0),
            Pin(size: 23.0, start: 38.0),
            child: Text(
              'تعديل الملف الشخصي',
              style: TextStyle(
                fontFamily: 'Europa',
                fontSize: 17,
                color: const Color(0xff98715f),
                fontWeight: FontWeight.w700,
                height: 1.7647058823529411,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 72.0, middle: 0.7921),
            Pin(size: 72.0, start: 119.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: const AssetImage(''),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 190.0, end: 171.0),
            Pin(size: 83.0, start: 131.0),
            child: Text(
              'متبرع\nريم محمد\n',
              style: TextStyle(
                fontFamily: 'Europa',
                fontSize: 17,
                color: const Color(0xff93796c),
                fontWeight: FontWeight.w700,
                height: 1.7647058823529411,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.right,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 270.7, middle: 0.5),
            Pin(size: 266.0, middle: 0.5),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 0.0, middle: 0.2105),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: -1.0),
                              child: SvgPicture.string(
                                _svg_mcdnb5,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 0.0, middle: 0.5827),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: -1.0),
                              child: SvgPicture.string(
                                _svg_mcdnb5,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 0.0, end: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: -1.0),
                              child: SvgPicture.string(
                                _svg_mcdnb5,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 193.4, end: 9.4),
                  Pin(size: 22.0, start: 4.0),
                  child: Text(
                    'الإشعارات',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 17,
                      color: const Color(0xff93796c),
                      fontWeight: FontWeight.w700,
                      height: 1.7647058823529411,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.right,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 194.4, end: 9.4),
                  Pin(size: 23.0, start: 102.0),
                  child: Text(
                    'المتابعين ',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 17,
                      color: const Color(0xff93796c),
                      fontWeight: FontWeight.w700,
                      height: 1.7647058823529411,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.right,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 167.4, end: 6.4),
                  Pin(size: 23.0, start: 214.0),
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 17,
                      color: const Color(0xff93796c),
                      fontWeight: FontWeight.w700,
                      height: 1.7647058823529411,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.right,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 58.0, start: 0.4),
                  Pin(size: 43.0, start: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: const AssetImage(''),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 58.0, start: 0.4),
                  Pin(size: 43.0, middle: 0.4709),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: const AssetImage(''),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 58.0, start: 0.4),
                  Pin(size: 43.0, end: 19.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: const AssetImage(''),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: -327.0, end: -327.0),
            Pin(start: -96.0, end: -60.0),
            child:
                // Adobe XD layer: 'Shape' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Shape shadow' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0x9d515457),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x4e97a7c3),
                          offset: Offset(10, 10),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 56.0, end: 47.0),
            Pin(size: 191.0, middle: 0.5007),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 14.0),
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
                        Pin(start: 131.0, end: 70.0),
                        Pin(size: 28.0, start: 17.0),
                        child: Text(
                          'تسجيل الخروج؟',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 20,
                            color: const Color(0xbd4c4c4c),
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 25.0, end: 70.0),
                        Pin(size: 21.0, start: 55.0),
                        child: Text(
                          'هل أنت متأكد  تريد تسجيل الخروج؟',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 16,
                            color: const Color(0xbd4c4c4c),
                            fontWeight: FontWeight.w700,
                            height: 1.4375,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 115.0, end: 36.0),
                  Pin(size: 60.0, middle: 0.771),
                  child:
                      // Adobe XD layer: 'large btn 1' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33.0),
                            color: const Color(0xbddda78d),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 22.0, end: 17.0),
                        Pin(size: 58.0, start: 2.0),
                        child: Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 15,
                            color: const Color(0xbd5f5f60),
                            fontWeight: FontWeight.w700,
                            height: 2.2666666666666666,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 115.0, start: 26.0),
                  Pin(size: 92.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'large btn 1' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 34.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33.0),
                            color: const Color(0xbdf6e5d9),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 14.0, end: 14.0),
                        Pin(size: 76.0, start: 16.0),
                        child: Text(
                          'إلغاء',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 20,
                            color: const Color(0xbd5e5e5f),
                            fontWeight: FontWeight.w700,
                            height: 1.7,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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

const String _svg_mcdnb5 =
    '<svg viewBox="0.0 0.0 270.7 1.0" ><path  d="M 0 0 L 270.7015380859375 7.874015864217654e-05" fill="none" stroke="#aeabab" stroke-width="1" stroke-miterlimit="8" stroke-linecap="butt" /></svg>';
