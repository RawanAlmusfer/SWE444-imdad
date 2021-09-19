import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
//updated version
class XDRegister1 extends StatelessWidget {
  XDRegister1({
    required Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x85f6f6f6),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 5.0),
            Pin(size: 18.0, start: 14.3),
            child:
                // Adobe XD layer: 'Status Bar' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 24.3, end: 0.0),
                  Pin(size: 11.3, start: 3.0),
                  child:
                      // Adobe XD layer: 'Battery' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 2.3),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'Border' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.67),
                            border: Border.all(
                                width: 1.0, color: const Color(0x59ffffff)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 1.3, end: 0.0),
                        Pin(size: 4.0, middle: 0.5),
                        child:
                            // Adobe XD layer: 'Cap' (shape)
                            SvgPicture.string(
                          _svg_e5um9,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 18.0, start: 2.0),
                        Pin(start: 2.0, end: 2.0),
                        child:
                            // Adobe XD layer: 'Capacity' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.33),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 15.3, end: 29.4),
                  Pin(size: 11.0, start: 3.0),
                  child:
                      // Adobe XD layer: 'Wifi' (shape)
                      SvgPicture.string(
                    _svg_fwmj47,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 17.0, end: 49.7),
                  Pin(size: 10.7, start: 3.3),
                  child:
                      // Adobe XD layer: 'Cellular Connection' (shape)
                      SvgPicture.string(
                    _svg_wkmgau,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 54.0, start: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Time Style' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 18.0, middle: 0.5),
                        child:
                            // Adobe XD layer: '↳ Time' (text)
                            Scrollbar(
                          child: SingleChildScrollView(
                            child: Text(
                              '9:41',
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 15,
                                color: const Color(0xffffffff),
                                letterSpacing: -0.3,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(),
          Pinned.fromPins(
            Pin(start: 35.0, end: -54.0),
            Pin(size: 243.0, middle: 0.2248),
            child:
                // Adobe XD layer: 'large btn 1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 91.0),
                  Pin(start: 0.0, end: 177.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 190.0, end: 143.0),
                  Pin(size: 34.0, start: 16.0),
                  child: Text(
                    'الاسم الاول',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0x484a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 3.0, end: 88.0),
                  Pin(start: 82.0, end: 95.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 91.0),
                  Pin(start: 177.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 126.0, middle: 0.5732),
                  Pin(size: 34.0, middle: 0.4689),
                  child: Text(
                    ' الاسم الأخير',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0xb24a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 288.0, start: 35.0),
                  Pin(size: 34.0, end: 19.0),
                  child: Text(
                    '                 البريد الالكتروني',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0xb24a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 22.0, end: 0.0),
                  Pin(size: 32.0, end: 36.0),
                  child: Text(
                    '   ',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0xb24a5759),
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
            Pin(start: 40.0, end: 39.0),
            Pin(size: 66.0, middle: 0.6952),
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
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 191.0, end: 66.0),
                  Pin(size: 31.0, start: 13.0),
                  child: Text(
                    'كلمة السر',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 23,
                      color: const Color(0x484a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.391304347826087,
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
            Pin(size: 158.0, middle: 0.5),
            Pin(size: 101.0, start: 48.0),
            child: Text(
              'إمداد',
              style: TextStyle(
                fontFamily: 'Kufam',
                fontSize: 76,
                color: const Color(0xff495759),
                fontWeight: FontWeight.w700,
                height: 1.8157894736842106,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.5, middle: 0.5852),
            Pin(size: 66.5, start: 32.3),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: -0.5),
                        Pin(start: 0.0, end: -0.4),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.5),
                              Pin(start: 0.0, end: 0.4),
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
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: SvgPicture.string(
                                _svg_nlqxep,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: SvgPicture.string(
                          _svg_vpdqik,
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
            Pin(start: 99.8, end: 305.8),
            Pin(start: 788.7, end: 498.7),
            child:
                // Adobe XD layer: 'Icon awesome-eye-sl…' (shape)
                SvgPicture.string(
              _svg_kop4ca,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 225.0, middle: 0.5025),
            Pin(size: 85.0, middle: 0.8026),
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
                      color: const Color(0xfeedd453),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 140.0, end: 140.0),
            Pin(size: 34.0, start: 1006.0),
            child: Text(
              'تسجيل الدخول',
              style: TextStyle(
                fontFamily: 'Europa-Bold',
                fontSize: 25,
                color: const Color(0xff4a5759),
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, end: 22.0),
            Pin(size: 72.0, start: 45.0),
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
                  child: Transform.rotate(
                    angle: 3.1416,
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
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 40.0, end: 39.0),
            Pin(size: 66.0, middle: 0.6169),
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
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 191.0, end: 66.0),
                  Pin(size: 31.0, start: 13.0),
                  child: Text(
                    'كلمة السر',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 23,
                      color: const Color(0x484a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.391304347826087,
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
            Pin(start: 99.8, end: 305.8),
            Pin(start: 885.7, end: 401.7),
            child:
                // Adobe XD layer: 'Icon awesome-eye-sl…' (shape)
                SvgPicture.string(
              _svg_oi9iy,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 35.0, end: -54.0),
            Pin(size: 243.0, middle: 0.4722),
            child:
                // Adobe XD layer: 'large btn 1' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 91.0),
                  Pin(start: 0.0, end: 177.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 184.0, end: 137.0),
                  Pin(size: 34.0, start: 16.0),
                  child: Text(
                    'اسم المسجد',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0x484a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 3.0, end: 88.0),
                  Pin(start: 82.0, end: 95.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 91.0),
                  Pin(start: 177.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xb2edd03c),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 100.0, middle: 0.5677),
                  Pin(size: 34.0, middle: 0.4689),
                  child: Text(
                    'اسم الحي',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0xb24a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 70.0, middle: 0.6021),
                  Pin(size: 33.0, end: 19.0),
                  child: Text(
                    'المدينة',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0xb24a5759),
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 22.0, end: 0.0),
                  Pin(size: 32.0, end: 36.0),
                  child: Text(
                    '   ',
                    style: TextStyle(
                      fontFamily: 'Europa-Bold',
                      fontSize: 25,
                      color: const Color(0xb24a5759),
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

const String _svg_e5um9 =
    '<svg viewBox="23.0 3.7 1.3 4.0" ><path transform="translate(23.0, 3.67)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#ffffff" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_fwmj47 =
    '<svg viewBox="378.4 3.0 15.3 11.0" ><path transform="translate(378.37, 3.0)" d="M 7.636517524719238 10.96560001373291 C 7.553837299346924 10.96560001373291 7.473147392272949 10.93181037902832 7.415117263793945 10.87290000915527 L 5.417117595672607 8.856900215148926 C 5.355837345123291 8.796520233154297 5.321717262268066 8.712539672851562 5.323517322540283 8.626500129699707 C 5.325307369232178 8.540619850158691 5.363027572631836 8.458290100097656 5.427017211914062 8.400600433349609 C 6.043807506561279 7.878690242767334 6.828487396240234 7.591279983520508 7.636517524719238 7.591279983520508 C 8.444547653198242 7.591279983520508 9.229227066040039 7.878699779510498 9.846017837524414 8.400600433349609 C 9.909987449645996 8.457460403442383 9.947707176208496 8.539790153503418 9.949517250061035 8.626500129699707 C 9.95131778717041 8.712539672851562 9.917197227478027 8.796520233154297 9.855916976928711 8.856900215148926 L 7.857917308807373 10.87290000915527 C 7.799037456512451 10.93268013000488 7.720407485961914 10.96560001373291 7.636517524719238 10.96560001373291 Z M 11.1447172164917 7.427700042724609 C 11.06472778320312 7.427700042724609 10.9886474609375 7.397650241851807 10.93051719665527 7.343100070953369 C 10.02612781524658 6.524199962615967 8.856297492980957 6.073200225830078 7.636517524719238 6.073200225830078 C 6.417577266693115 6.073200225830078 5.248707294464111 6.524189949035645 4.345217227935791 7.343100070953369 C 4.287087440490723 7.397650241851807 4.211007595062256 7.427700042724609 4.131017208099365 7.427700042724609 C 4.048027515411377 7.427700042724609 3.970037460327148 7.395420074462891 3.911417484283447 7.336800098419189 L 2.757617473602295 6.170400142669678 C 2.695777416229248 6.108550071716309 2.662217378616333 6.026730060577393 2.663117408752441 5.940000057220459 C 2.664007425308228 5.853139877319336 2.69884729385376 5.771959781646729 2.761217355728149 5.711400032043457 C 4.090717315673828 4.47461986541748 5.822447299957275 3.793499946594238 7.637417316436768 3.793499946594238 C 9.452387809753418 3.793499946594238 11.18411731719971 4.47461986541748 12.51361751556396 5.711400032043457 C 12.57655715942383 5.772540092468262 12.61171722412109 5.853720188140869 12.61261749267578 5.940000057220459 C 12.61350727081299 6.025139808654785 12.57939720153809 6.109109878540039 12.51901721954346 6.170400142669678 L 11.36431694030762 7.336800098419189 C 11.30568695068359 7.395420074462891 11.227707862854 7.427700042724609 11.1447172164917 7.427700042724609 Z M 13.80421733856201 4.743000030517578 C 13.72327709197998 4.743000030517578 13.64720726013184 4.711999893188477 13.59001731872559 4.655700206756592 C 11.97507762908936 3.121779918670654 9.860747337341309 2.276999950408936 7.636517524719238 2.276999950408936 C 5.41138744354248 2.276999950408936 3.297057390213013 3.121769905090332 1.683017373085022 4.655700206756592 C 1.625837445259094 4.711989879608154 1.549757361412048 4.743000030517578 1.468817353248596 4.743000030517578 C 1.385827422142029 4.743000030517578 1.3078373670578 4.710720062255859 1.249217391014099 4.652100086212158 L 0.09361741691827774 3.485699892044067 C 0.03236741945147514 3.423549890518188 -0.0008725797524675727 3.342360019683838 1.742024505801965e-05 3.257100105285645 C 0.000917420256882906 3.170560121536255 0.03511742129921913 3.089689970016479 0.09631741791963577 3.029400110244751 C 2.134447336196899 1.075860023498535 4.812267303466797 0 7.636517524719238 0 C 10.46076774597168 0 13.13859748840332 1.075860023498535 15.17671775817871 3.029400110244751 C 15.23734760284424 3.090039968490601 15.27211761474609 3.173029899597168 15.27211761474609 3.257100105285645 C 15.2730073928833 3.342360019683838 15.23976707458496 3.423549890518188 15.17851734161377 3.485699892044067 L 14.02291774749756 4.652100086212158 C 13.96428775787354 4.710720062255859 13.88662719726562 4.743000030517578 13.80421733856201 4.743000030517578 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_wkmgau =
    '<svg viewBox="356.3 3.3 17.0 10.7" ><path transform="translate(356.34, 3.34)" d="M 16.00020027160645 10.6668004989624 L 15.00029945373535 10.6668004989624 C 14.44894981384277 10.6668004989624 14.00039958953857 10.2182502746582 14.00039958953857 9.666900634765625 L 14.00039958953857 0.9998999834060669 C 14.00039958953857 0.4485500156879425 14.44894981384277 0 15.00029945373535 0 L 16.00020027160645 0 C 16.55154991149902 0 17.00010108947754 0.4485500156879425 17.00010108947754 0.9998999834060669 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.2182502746582 16.55154991149902 10.6668004989624 16.00020027160645 10.6668004989624 Z M 11.33369922637939 10.6668004989624 L 10.33290004730225 10.6668004989624 C 9.781549453735352 10.6668004989624 9.332999229431152 10.2182502746582 9.332999229431152 9.666900634765625 L 9.332999229431152 3.333600044250488 C 9.332999229431152 2.782249927520752 9.781549453735352 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33369922637939 2.333699941635132 C 11.88504981994629 2.333699941635132 12.33360004425049 2.782249927520752 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.2182502746582 11.88504981994629 10.6668004989624 11.33369922637939 10.6668004989624 Z M 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 C 5.115049839019775 10.6668004989624 4.666500091552734 10.2182502746582 4.666500091552734 9.666900634765625 L 4.666500091552734 5.66640043258667 C 4.666500091552734 5.115050315856934 5.115049839019775 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218140125274658 4.666500091552734 7.667099952697754 5.115050315856934 7.667099952697754 5.66640043258667 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.2182502746582 7.218140125274658 10.6668004989624 6.666300296783447 10.6668004989624 Z M 1.999799966812134 10.6668004989624 L 0.9998999834060669 10.6668004989624 C 0.4485500156879425 10.6668004989624 0 10.2182502746582 0 9.666900634765625 L 0 7.667100429534912 C 0 7.115260124206543 0.4485500156879425 6.666300296783447 0.9998999834060669 6.666300296783447 L 1.999799966812134 6.666300296783447 C 2.55115008354187 6.666300296783447 2.99970006942749 7.115260124206543 2.99970006942749 7.667100429534912 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.2182502746582 2.55115008354187 10.6668004989624 1.999799966812134 10.6668004989624 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_nlqxep =
    '<svg viewBox="0.0 0.0 91.0 66.9" ><path transform="translate(-0.5, 90.5)" d="M 0.5 -23.63259506225586 L 91.49379730224609 -23.63259506225586 L 91.49379730224609 -90.5 L 0.5 -90.5 L 0.5 -23.63259506225586 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vpdqik =
    '<svg viewBox="0.0 0.0 90.5 66.5" ><path transform="translate(-0.5, 90.5)" d="M 0.5 -90.5 L 90.99383544921875 -90.5 L 90.99383544921875 -23.99999618530273 L 0.5 -23.99999618530273 L 0.5 -90.5 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_kop4ca =
    '<svg viewBox="99.8 788.7 22.4 18.7" ><path transform="translate(99.8, 788.67)" d="M 11.19999504089355 14.58302974700928 C 8.545257568359375 14.58302974700928 6.396268367767334 12.44258785247803 6.198520183563232 9.730124473571777 L 2.527039289474487 6.77448558807373 C 2.044391393661499 7.405205726623535 1.600243926048279 8.072019577026367 1.241845846176147 8.801177024841309 C 1.079472184181213 9.135750770568848 1.079472184181213 9.530808448791504 1.241845965385437 9.865382194519043 C 3.139886140823364 13.72298908233643 6.89746618270874 16.33300590515137 11.19999504089355 16.33300590515137 C 12.14183902740479 16.33300590515137 13.05043601989746 16.18717575073242 13.92613124847412 15.95165920257568 L 12.10998916625977 14.48787403106689 C 11.81004810333252 14.54822635650635 11.50546646118164 14.580078125 11.19999504089355 14.58302783966064 Z M 22.18363952636719 16.70123100280762 L 18.31440544128418 13.58627319335938 C 19.48975944519043 12.55447864532471 20.45641708374023 11.2895336151123 21.15814590454102 9.865015983581543 C 21.32051658630371 9.530441284179688 21.32051658630371 9.135385513305664 21.15814208984375 8.800813674926758 C 19.26010513305664 4.943206787109375 15.50252342224121 2.333188772201538 11.19999504089355 2.333188772201538 C 9.398028373718262 2.335463762283325 7.625329494476318 2.808004379272461 6.043822765350342 3.707648992538452 L 1.59114408493042 0.1227491647005081 C 1.346941113471985 -0.07519258558750153 0.9949078559875488 -0.02931437082588673 0.8050482273101807 0.2251957356929779 L 0.1180018037557602 1.146485805511475 C -0.07178559899330139 1.400801181793213 -0.02775616757571697 1.767220973968506 0.2163514047861099 1.964964747428894 L 20.80884552001953 18.54344749450684 C 21.05305099487305 18.74138641357422 21.40508651733398 18.69550895690918 21.59494209289551 18.44099617004395 L 22.28234100341797 17.51970672607422 C 22.47204780578613 17.26529884338379 22.4278564453125 16.89886283874512 22.18364143371582 16.70123100280762 Z M 15.75347137451172 11.52421569824219 L 14.37797832489014 10.4166259765625 C 14.49381542205811 10.06789588928223 14.55525970458984 9.702080726623535 14.55997657775879 9.333097457885742 C 14.57382488250732 8.237607002258301 14.08801746368408 7.200209140777588 13.25068759918213 6.537224769592285 C 12.41335678100586 5.874238967895508 11.32376670837402 5.664261341094971 10.31414890289307 5.97131872177124 C 10.52519989013672 6.26921558380127 10.63936805725098 6.629559516906738 10.63999843597412 6.999794006347656 C 10.63477516174316 7.122997760772705 10.61670303344727 7.245242118835449 10.58609676361084 7.364373207092285 L 8.009758949279785 5.290284633636475 C 8.90470027923584 4.511255741119385 10.03370666503906 4.084063053131104 11.19999599456787 4.083166122436523 C 12.53690719604492 4.08239221572876 13.81927490234375 4.635260105133057 14.76461315155029 5.619980812072754 C 15.70995616912842 6.604701519012451 16.24071311950684 7.940492153167725 16.23997116088867 9.333097457885742 C 16.23997116088867 10.12168121337891 16.05482292175293 10.8566722869873 15.75347137451172 11.52458000183105 Z" fill="#b4a39a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_oi9iy =
    '<svg viewBox="99.8 885.7 22.4 18.7" ><path transform="translate(99.8, 885.67)" d="M 11.19999504089355 14.58302974700928 C 8.545257568359375 14.58302974700928 6.396268367767334 12.44258785247803 6.198520183563232 9.730124473571777 L 2.527039289474487 6.77448558807373 C 2.044391393661499 7.405205726623535 1.600243926048279 8.072019577026367 1.241845846176147 8.801177024841309 C 1.079472184181213 9.135750770568848 1.079472184181213 9.530808448791504 1.241845965385437 9.865382194519043 C 3.139886140823364 13.72298908233643 6.89746618270874 16.33300590515137 11.19999504089355 16.33300590515137 C 12.14183902740479 16.33300590515137 13.05043601989746 16.18717575073242 13.92613124847412 15.95165920257568 L 12.10998916625977 14.48787403106689 C 11.81004810333252 14.54822635650635 11.50546646118164 14.580078125 11.19999504089355 14.58302783966064 Z M 22.18363952636719 16.70123100280762 L 18.31440544128418 13.58627319335938 C 19.48975944519043 12.55447864532471 20.45641708374023 11.2895336151123 21.15814590454102 9.865015983581543 C 21.32051658630371 9.530441284179688 21.32051658630371 9.135385513305664 21.15814208984375 8.800813674926758 C 19.26010513305664 4.943206787109375 15.50252342224121 2.333188772201538 11.19999504089355 2.333188772201538 C 9.398028373718262 2.335463762283325 7.625329494476318 2.808004379272461 6.043822765350342 3.707648992538452 L 1.59114408493042 0.1227491647005081 C 1.346941113471985 -0.07519258558750153 0.9949078559875488 -0.02931437082588673 0.8050482273101807 0.2251957356929779 L 0.1180018037557602 1.146485805511475 C -0.07178559899330139 1.400801181793213 -0.02775616757571697 1.767220973968506 0.2163514047861099 1.964964747428894 L 20.80884552001953 18.54344749450684 C 21.05305099487305 18.74138641357422 21.40508651733398 18.69550895690918 21.59494209289551 18.44099617004395 L 22.28234100341797 17.51970672607422 C 22.47204780578613 17.26529884338379 22.4278564453125 16.89886283874512 22.18364143371582 16.70123100280762 Z M 15.75347137451172 11.52421569824219 L 14.37797832489014 10.4166259765625 C 14.49381542205811 10.06789588928223 14.55525970458984 9.702080726623535 14.55997657775879 9.333097457885742 C 14.57382488250732 8.237607002258301 14.08801746368408 7.200209140777588 13.25068759918213 6.537224769592285 C 12.41335678100586 5.874238967895508 11.32376670837402 5.664261341094971 10.31414890289307 5.97131872177124 C 10.52519989013672 6.26921558380127 10.63936805725098 6.629559516906738 10.63999843597412 6.999794006347656 C 10.63477516174316 7.122997760772705 10.61670303344727 7.245242118835449 10.58609676361084 7.364373207092285 L 8.009758949279785 5.290284633636475 C 8.90470027923584 4.511255741119385 10.03370666503906 4.084063053131104 11.19999599456787 4.083166122436523 C 12.53690719604492 4.08239221572876 13.81927490234375 4.635260105133057 14.76461315155029 5.619980812072754 C 15.70995616912842 6.604701519012451 16.24071311950684 7.940492153167725 16.23997116088867 9.333097457885742 C 16.23997116088867 10.12168121337891 16.05482292175293 10.8566722869873 15.75347137451172 11.52458000183105 Z" fill="#b4a39a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
