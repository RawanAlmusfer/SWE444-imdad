import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDRegistration1 extends StatelessWidget {
  XDRegistration1({
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
            Pin(start: 44.0, end: 43.0),
            Pin(size: 138.0, middle: 0.8071),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 1.0, end: 0.0),
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
                  Pin(start: 0.0, end: 1.0),
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
                        Pin(size: 30.0, start: 13.0),
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
                Pinned.fromPins(
                  Pin(start: 38.0, end: 280.6),
                  Pin(start: 98.7, end: 20.7),
                  child:
                      // Adobe XD layer: 'Icon awesome-eye-sl…' (shape)
                      SvgPicture.string(
                    _svg_g6o09y,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
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
          Pinned.fromPins(
            Pin(start: 44.0, end: 44.0),
            Pin(size: 144.0, middle: 0.2008),
            child:
                // Adobe XD layer: 'large btn 1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 84.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb5fffbf4),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 202.0, end: 38.0),
                  Pin(size: 30.0, start: 15.0),
                  child: Text(
                    'الاسم الأول',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 22,
                      color: const Color(0x5d4c4c4c),
                      fontWeight: FontWeight.w700,
                      height: 1.4090909090909092,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 84.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb5fffbf4),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 104.0, end: 38.0),
                  Pin(size: 30.0, end: 15.0),
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
                            color: const Color(0x424c4c4c),
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
            Pin(start: 44.0, end: 44.0),
            Pin(size: 60.0, middle: 0.4607),
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
                  Pin(start: 174.0, end: 54.0),
                  Pin(size: 30.0, start: 13.0),
                  child: Text(
                    'اسم المسجد',
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 22,
                      color: const Color(0x5c4c4c4c),
                      fontWeight: FontWeight.w700,
                      height: 1.4090909090909092,
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
            Pin(start: 44.0, end: 44.0),
            Pin(size: 60.0, middle: 0.552),
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
                  Pin(size: 88.0, middle: 0.7381),
                  Pin(size: 30.0, middle: 0.5),
                  child:
                      // Adobe XD layer: 'large btn 1' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 30.0, start: 0.0),
                        child: Text(
                          'اسم الحي',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 22,
                            color: const Color(0x424c4c4c),
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
            Pin(start: 44.0, end: 44.0),
            Pin(size: 60.0, middle: 0.6432),
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
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
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
                            color: const Color(0x80fffbf4),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 199.0, end: 79.0),
                        Pin(size: 30.0, start: 13.0),
                        child: Text(
                          'المدينه',
                          style: TextStyle(
                            fontFamily: 'Europa',
                            fontSize: 22,
                            color: const Color(0x424c4c4c),
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
            Pin(start: 44.0, end: 44.0),
            Pin(size: 60.0, middle: 0.3695),
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
            Pin(start: 207.0, end: 71.0),
            Pin(size: 30.0, start: 333.0),
            child: Text(
              'البريد الالكتروني ',
              style: TextStyle(
                fontFamily: 'Europa',
                fontSize: 22,
                color: const Color(0x824c4c4c),
                fontWeight: FontWeight.w700,
                height: 1.4090909090909092,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_g6o09y =
    '<svg viewBox="80.0 617.7 22.4 18.7" ><path transform="translate(80.0, 617.67)" d="M 11.19999504089355 14.58302974700928 C 8.545257568359375 14.58302974700928 6.396268367767334 12.44258785247803 6.198520183563232 9.730124473571777 L 2.527039289474487 6.77448558807373 C 2.044391393661499 7.405205726623535 1.600243926048279 8.072019577026367 1.241845846176147 8.801177024841309 C 1.079472184181213 9.135750770568848 1.079472184181213 9.530808448791504 1.241845965385437 9.865382194519043 C 3.139886140823364 13.72298908233643 6.89746618270874 16.33300590515137 11.19999504089355 16.33300590515137 C 12.14183902740479 16.33300590515137 13.05043601989746 16.18717575073242 13.92613124847412 15.95165920257568 L 12.10998916625977 14.48787403106689 C 11.81004810333252 14.54822635650635 11.50546646118164 14.580078125 11.19999504089355 14.58302783966064 Z M 22.18363952636719 16.70123100280762 L 18.31440544128418 13.58627319335938 C 19.48975944519043 12.55447864532471 20.45641708374023 11.2895336151123 21.15814590454102 9.865015983581543 C 21.32051658630371 9.530441284179688 21.32051658630371 9.135385513305664 21.15814208984375 8.800813674926758 C 19.26010513305664 4.943206787109375 15.50252342224121 2.333188772201538 11.19999504089355 2.333188772201538 C 9.398028373718262 2.335463762283325 7.625329494476318 2.808004379272461 6.043822765350342 3.707648992538452 L 1.59114408493042 0.1227491647005081 C 1.346941113471985 -0.07519258558750153 0.9949078559875488 -0.02931437082588673 0.8050482273101807 0.2251957356929779 L 0.1180018037557602 1.146485805511475 C -0.07178559899330139 1.400801181793213 -0.02775616757571697 1.767220973968506 0.2163514047861099 1.964964747428894 L 20.80884552001953 18.54344749450684 C 21.05305099487305 18.74138641357422 21.40508651733398 18.69550895690918 21.59494209289551 18.44099617004395 L 22.28234100341797 17.51970672607422 C 22.47204780578613 17.26529884338379 22.4278564453125 16.89886283874512 22.18364143371582 16.70123100280762 Z M 15.75347137451172 11.52421569824219 L 14.37797832489014 10.4166259765625 C 14.49381542205811 10.06789588928223 14.55525970458984 9.702080726623535 14.55997657775879 9.333097457885742 C 14.57382488250732 8.237607002258301 14.08801746368408 7.200209140777588 13.25068759918213 6.537224769592285 C 12.41335678100586 5.874238967895508 11.32376670837402 5.664261341094971 10.31414890289307 5.97131872177124 C 10.52519989013672 6.26921558380127 10.63936805725098 6.629559516906738 10.63999843597412 6.999794006347656 C 10.63477516174316 7.122997760772705 10.61670303344727 7.245242118835449 10.58609676361084 7.364373207092285 L 8.009758949279785 5.290284633636475 C 8.90470027923584 4.511255741119385 10.03370666503906 4.084063053131104 11.19999599456787 4.083166122436523 C 12.53690719604492 4.08239221572876 13.81927490234375 4.635260105133057 14.76461315155029 5.619980812072754 C 15.70995616912842 6.604701519012451 16.24071311950684 7.940492153167725 16.23997116088867 9.333097457885742 C 16.23997116088867 10.12168121337891 16.05482292175293 10.8566722869873 15.75347137451172 11.52458000183105 Z" fill="#b4a39a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
