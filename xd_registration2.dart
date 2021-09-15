import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class XDRegistration2 extends StatelessWidget {
  XDRegistration2({
   key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x85d66f3e),
      body: Stack(
        children: <Widget>[
          Container(),
          Pinned.fromPins(
            Pin(size: 209.0, middle: 0.5479),
            Pin(size: 119.0, start: 32.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 177.0, end: 0.0),
                  Pin(start: 0.0, end: 7.0),
                  child:
                      // Adobe XD layer: 'Picture1' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(95.0),
                      image: DecorationImage(
                        image: const AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 138.0, start: 0.0),
                  Pin(size: 47.0, end: 0.0),
                  child: Text(
                    'مرحبا بك!',
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 35,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                      height: 1.1428571428571428,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 4.0, end: 44.0),
            Pin(size: 2.0, end: 47.0),
            child:
                // Adobe XD layer: 'large btn 1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 2.0, start: 0.0),
                  child: Text(
                    'التسجيل',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 1,
                      color: const Color(0xffd66f3e),
                      fontWeight: FontWeight.w700,
                      height: 1,
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
            Pin(start: 43.0, end: 43.0),
            Pin(size: 383.0, middle: 0.3352),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 226.0, start: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 2.0, end: 0.0),
                        Pin(size: 60.0, start: 0.0),
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
                                  color: const Color(0xb5fffbf4),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 202.0, end: 38.0),
                              Pin(size: 30.0, start: 12.0),
                              child: Text(
                                'الاسم الأول',
                                style: TextStyle(
                                  fontFamily: 'Europa',
                                  fontSize: 22,
                                  color: const Color(0x5d4c4c4c),
                                  fontWeight: FontWeight.w700,
                                  height: 1.4090909090909092,
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
                        Pin(start: 2.0, end: 0.0),
                        Pin(size: 60.0, middle: 0.494),
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
                                  color: const Color(0xb5fffbf4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 104.0, end: 42.0),
                        Pin(size: 30.0, middle: 0.4796),
                        child:
                            // Adobe XD layer: 'large btn 1' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(size: 30.0, start: 0.0),
                              child: Text(
                                'الاسم الأخير',
                                style: TextStyle(
                                  fontFamily: 'Europa',
                                  fontSize: 22,
                                  color: const Color(0x5c4c4c4c),
                                  fontWeight: FontWeight.w700,
                                  height: 1.4090909090909092,
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
                        Pin(start: 0.0, end: 2.0),
                        Pin(size: 60.0, end: 0.0),
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
                                  color: const Color(0xb5fffbf4),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 155.0, end: 35.0),
                              Pin(size: 30.0, start: 13.0),
                              child: Text(
                                'البريد الالكتروني ',
                                style: TextStyle(
                                  fontFamily: 'Europa',
                                  fontSize: 22,
                                  color: const Color(0x5c4c4c4c),
                                  fontWeight: FontWeight.w700,
                                  height: 1.4090909090909092,
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
                Pinned.fromPins(
                  Pin(start: 0.0, end: 2.0),
                  Pin(size: 60.0, middle: 0.7461),
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
                            color: const Color(0xb5fffbf4),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 215.0, end: 37.0),
                        Pin(size: 30.0, start: 13.0),
                        child: Text(
                          'كلمة السر',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 22,
                            color: const Color(0x5c4c4c4c),
                            fontWeight: FontWeight.w700,
                            height: 1.4090909090909092,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(),
                Pinned.fromPins(
                  Pin(start: 1.0, end: 1.0),
                  Pin(size: 60.0, end: 0.0),
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
                            color: const Color(0xb5fffbf4),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 170.0, end: 34.0),
                        Pin(size: 30.0, start: 15.0),
                        child: Text(
                          'تأكيد كلمة السر',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 22,
                            color: const Color(0x5c4c4c4c),
                            fontWeight: FontWeight.w700,
                            height: 1.4090909090909092,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 249.0, end: 79.0),
            Pin(size: 40.0, start: 803.0),
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
            Pin(size: 90.0, start: 58.0),
            Pin(size: 72.0, end: 63.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 4.0, end: 9.0),
                  child:
                      // Adobe XD layer: 'large btn 1' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: const Color(0xb5fffbf4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 53.0, middle: 0.4865),
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
        ],
      ),
    );
  }
}
