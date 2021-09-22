import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRequest extends StatefulWidget {
  const PostRequest({Key? key}) : super(key: key);
  @override
  _PostRequestState createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  final _formKey = GlobalKey<FormState>();
  String? value;
  String postedBy= "", type= "Funds";
  int amount = 0;
  String description = "";
  String title = "";
  final List<String> items = ['Funds'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Stack(
        children: <Widget>[
          Stack(
              children: <Widget>[
          Pinned.fromPins(
            Pin(size: 24.3, end: 0.0),
            Pin(size: 11.3, start: 2.5),
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
            Pin(size: 11.0, start: 2.5),
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
            Pin(size: 10.7, start: 2.8),
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
                      Text(
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
              ],
            ),
          ),
              ],
            ),
          Pinned.fromPins(
            Pin(size: 244.0, middle: 0.5),
            Pin(size: 30.0, start: 154.5),
            child: Text(
              'نموذج إضافة طلب جديد',
              style: TextStyle(
                fontFamily: 'Europa-Bold',
                fontSize: 25,
                color: const Color(0xff4a5759),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ), //here
          Pinned.fromPins(
            Pin(start: 23, end: 23.3),
            Pin(size: 469.8, middle: 0.55),
            child:
                // Adobe XD layer: 'card_request1' (group)
                Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                        // Adobe XD layer: 'card' (shape)
                        SvgPicture.string(
                      _svg_jeae9u,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  Pinned.fromPins(
                    Pin(size: 70.0, end: 16.8),
                    Pin(size: 20.0, start: 32.5),
                    child: Text(
                      'نوع الطلب',
                      style: TextStyle(
                        fontFamily: 'Europa-Regular',
                        fontSize: 16,
                        color: const Color(0xff334856),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 200.0, start: 29.4),
                    Pin(size: 30, start: 27.5),
                    child:
                        // Adobe XD layer: 'dropdown list' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xffffffff),
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: value,
                                  items: items.map<DropdownMenuItem<String>>(
                                      (dropdownMenuItem) {
                                    return DropdownMenuItem(
                                      value: dropdownMenuItem,
                                      child: Text(dropdownMenuItem),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      setState(() => this.value = value),
                                  hint: Text("Select item"),
                                  icon: Icon(Icons.arrow_drop_down_circle),
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 70.0, end: 20.8),
                    Pin(size: 20.0, middle: 0.1871),
                    child: Text(
                      'عنوان الطلب',
                      style: TextStyle(
                        fontFamily: 'Europa-Regular',
                        fontSize: 16,
                        color: const Color(0xff334856),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 198.0, start: 29.8),
                    Pin(size: 28.0, middle: 0.18),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 0.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter title',
                              contentPadding:
                                  EdgeInsets.fromLTRB(0, 0, 0, 12.5),
                              hintStyle: TextStyle(fontSize: 16)),
                          onChanged: (_val) {
                            title = _val;
                          }, // onchanged
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 80.0, end: 20.8),
                    Pin(size: 20.0, middle: 0.3022),
                    child: Text(
                      'تفاصيل الطلب',
                      style: TextStyle(
                        fontFamily: 'Europa-Regular',
                        fontSize: 16,
                        color: const Color(0xff334856),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 50.0, middle: 0.585),
                    Pin(size: 18.0, middle: 0.3753),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Europa-Light',
                          fontSize: 15,
                          color: const Color(0xff4a5759),
                        ),
                        children: [
                          TextSpan(
                            text: 'المبلغ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: ':  ',
                            style: TextStyle(
                              color: const Color(0xffd97d54),
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
                    Pin(size: 28.0, middle: 0.3702),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
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
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(38, 0, 0, 0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Amount',
                              contentPadding:
                                  EdgeInsets.fromLTRB(0, 0, 0, 16),
                              hintStyle: TextStyle(fontSize: 13)),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: (_val) {
                            var _val2 = int.parse(_val), amount = _val2;
                          }, // onchanged
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 16.0, start: 44.8),
                    Pin(size: 14.0, middle: 0.3742),
                    child: Text(
                      'ريال',
                      style: TextStyle(
                        fontFamily: 'Academy Engraved LET',
                        fontSize: 11,
                        color: const Color(0xffd2d2d2),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 135.7, middle: 0.5),
                    Pin(size: 25.3, end: 50.9),
                    child:
                        // Adobe XD layer: 'add button' (group)
                        Stack(
                      children: <Widget>[
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
                                            child:
                                               ElevatedButton(
                                                onPressed: add,
                                                child: Text(
                                                  "إضافة",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: "lato",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                 style: ButtonStyle(
                                                   backgroundColor: MaterialStateProperty.all(const Color(0xdeedd03c)),
                                                 ),
                                              )
                                            
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
                  Pinned.fromPins( // here
                    Pin(start: 27.8, end: 27.8),
                    Pin(size: 110.0, middle: 0.68),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 0.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.fromLTRB(0, 16, 0, 16),
                              ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(150)
                          ],
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          onChanged: (_val) {
                            description = _val;
                          }, // onchanged
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 74.0, end: 21.8),
                    Pin(size: 30.0, middle: 0.4727),
                    child: Text(
                      'وصف إضافي',
                      style: TextStyle(
                        fontFamily: 'Europa-Regular',
                        fontSize: 16,
                        color: const Color(0xff334856),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 81.0, start: 0.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'manger bar' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'btn_white' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(50.0),
                                  ),
                                  color: const Color(0xdeedd03c),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 170.0, middle: 0.5),
                  Pin(size: 34.0, middle: 0.75),
                  child: Text(
                    'إضافة طلب جديد',
                    style: TextStyle(
                      fontFamily: 'Noto Sans Oriya',
                      fontSize: 24,
                      color: const Color(0xff334856),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 91.0, end: 0.0),
            child:
                // Adobe XD layer: 'manger bar' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'btn_white' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                            ),
                            color: const Color(0xdeffffff),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 30.0, middle: 0.5),
                  Pin(size: 29.9, middle: 0.5),
                  child:
                      // Adobe XD layer: 'Icon ionic-ios-add' (shape)
                      SvgPicture.string(
                    _svg_znb,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 25.4, middle: 0.2471),
                  Pin(size: 28.2, middle: 0.4869),
                  child:
                      // Adobe XD layer: 'icn_home_active' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'icn_home_active' (shape)
                            SvgPicture.string(
                          _svg_w5lg9z,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 22.0, middle: 0.7466),
                  Pin(size: 28.5, middle: 0.4846),
                  child:
                      // Adobe XD layer: 'icn_profile_active' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 4.6, end: 4.4),
                        Pin(size: 13.0, start: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            border: Border.all(
                                width: 2.0, color: const Color(0xff4a5759)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 12.6, end: 0.0),
                        child: SvgPicture.string(
                          _svg_hfkd7,
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
        ],
      ),
    );
  }
  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('Requests');

    var data = {
      'title': title,
      'type': type,
      'posted_by': postedBy,
      'description': description,
      'amount': amount,
    };

    ref.add(data);

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => PostRequest(),
      ),
    )
        .then((value) {
      print("Calling Set State !");
      setState(() {});
    });

    _formKey.currentState?.reset();
  }
}

const String _svg_e5um9 =
    '<svg viewBox="23.0 3.7 1.3 4.0" ><path transform="translate(23.0, 3.67)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#ffffff" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_fwmj47 =
    '<svg viewBox="378.4 3.0 15.3 11.0" ><path transform="translate(378.37, 3.0)" d="M 7.636517524719238 10.96560001373291 C 7.553837299346924 10.96560001373291 7.473147392272949 10.93181037902832 7.415117263793945 10.87290000915527 L 5.417117595672607 8.856900215148926 C 5.355837345123291 8.796520233154297 5.321717262268066 8.712539672851562 5.323517322540283 8.626500129699707 C 5.325307369232178 8.540619850158691 5.363027572631836 8.458290100097656 5.427017211914062 8.400600433349609 C 6.043807506561279 7.878690242767334 6.828487396240234 7.591279983520508 7.636517524719238 7.591279983520508 C 8.444547653198242 7.591279983520508 9.229227066040039 7.878699779510498 9.846017837524414 8.400600433349609 C 9.909987449645996 8.457460403442383 9.947707176208496 8.539790153503418 9.949517250061035 8.626500129699707 C 9.95131778717041 8.712539672851562 9.917197227478027 8.796520233154297 9.855916976928711 8.856900215148926 L 7.857917308807373 10.87290000915527 C 7.799037456512451 10.93268013000488 7.720407485961914 10.96560001373291 7.636517524719238 10.96560001373291 Z M 11.1447172164917 7.427700042724609 C 11.06472778320312 7.427700042724609 10.9886474609375 7.397650241851807 10.93051719665527 7.343100070953369 C 10.02612781524658 6.524199962615967 8.856297492980957 6.073200225830078 7.636517524719238 6.073200225830078 C 6.417577266693115 6.073200225830078 5.248707294464111 6.524189949035645 4.345217227935791 7.343100070953369 C 4.287087440490723 7.397650241851807 4.211007595062256 7.427700042724609 4.131017208099365 7.427700042724609 C 4.048027515411377 7.427700042724609 3.970037460327148 7.395420074462891 3.911417484283447 7.336800098419189 L 2.757617473602295 6.170400142669678 C 2.695777416229248 6.108550071716309 2.662217378616333 6.026730060577393 2.663117408752441 5.940000057220459 C 2.664007425308228 5.853139877319336 2.69884729385376 5.771959781646729 2.761217355728149 5.711400032043457 C 4.090717315673828 4.47461986541748 5.822447299957275 3.793499946594238 7.637417316436768 3.793499946594238 C 9.452387809753418 3.793499946594238 11.18411731719971 4.47461986541748 12.51361751556396 5.711400032043457 C 12.57655715942383 5.772540092468262 12.61171722412109 5.853720188140869 12.61261749267578 5.940000057220459 C 12.61350727081299 6.025139808654785 12.57939720153809 6.109109878540039 12.51901721954346 6.170400142669678 L 11.36431694030762 7.336800098419189 C 11.30568695068359 7.395420074462891 11.227707862854 7.427700042724609 11.1447172164917 7.427700042724609 Z M 13.80421733856201 4.743000030517578 C 13.72327709197998 4.743000030517578 13.64720726013184 4.711999893188477 13.59001731872559 4.655700206756592 C 11.97507762908936 3.121779918670654 9.860747337341309 2.276999950408936 7.636517524719238 2.276999950408936 C 5.41138744354248 2.276999950408936 3.297057390213013 3.121769905090332 1.683017373085022 4.655700206756592 C 1.625837445259094 4.711989879608154 1.549757361412048 4.743000030517578 1.468817353248596 4.743000030517578 C 1.385827422142029 4.743000030517578 1.3078373670578 4.710720062255859 1.249217391014099 4.652100086212158 L 0.09361741691827774 3.485699892044067 C 0.03236741945147514 3.423549890518188 -0.0008725797524675727 3.342360019683838 1.742024505801965e-05 3.257100105285645 C 0.000917420256882906 3.170560121536255 0.03511742129921913 3.089689970016479 0.09631741791963577 3.029400110244751 C 2.134447336196899 1.075860023498535 4.812267303466797 0 7.636517524719238 0 C 10.46076774597168 0 13.13859748840332 1.075860023498535 15.17671775817871 3.029400110244751 C 15.23734760284424 3.090039968490601 15.27211761474609 3.173029899597168 15.27211761474609 3.257100105285645 C 15.2730073928833 3.342360019683838 15.23976707458496 3.423549890518188 15.17851734161377 3.485699892044067 L 14.02291774749756 4.652100086212158 C 13.96428775787354 4.710720062255859 13.88662719726562 4.743000030517578 13.80421733856201 4.743000030517578 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_wkmgau =
    '<svg viewBox="356.3 3.3 17.0 10.7" ><path transform="translate(356.34, 3.34)" d="M 16.00020027160645 10.6668004989624 L 15.00029945373535 10.6668004989624 C 14.44894981384277 10.6668004989624 14.00039958953857 10.2182502746582 14.00039958953857 9.666900634765625 L 14.00039958953857 0.9998999834060669 C 14.00039958953857 0.4485500156879425 14.44894981384277 0 15.00029945373535 0 L 16.00020027160645 0 C 16.55154991149902 0 17.00010108947754 0.4485500156879425 17.00010108947754 0.9998999834060669 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.2182502746582 16.55154991149902 10.6668004989624 16.00020027160645 10.6668004989624 Z M 11.33369922637939 10.6668004989624 L 10.33290004730225 10.6668004989624 C 9.781549453735352 10.6668004989624 9.332999229431152 10.2182502746582 9.332999229431152 9.666900634765625 L 9.332999229431152 3.333600044250488 C 9.332999229431152 2.782249927520752 9.781549453735352 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33369922637939 2.333699941635132 C 11.88504981994629 2.333699941635132 12.33360004425049 2.782249927520752 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.2182502746582 11.88504981994629 10.6668004989624 11.33369922637939 10.6668004989624 Z M 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 C 5.115049839019775 10.6668004989624 4.666500091552734 10.2182502746582 4.666500091552734 9.666900634765625 L 4.666500091552734 5.66640043258667 C 4.666500091552734 5.115050315856934 5.115049839019775 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218140125274658 4.666500091552734 7.667099952697754 5.115050315856934 7.667099952697754 5.66640043258667 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.2182502746582 7.218140125274658 10.6668004989624 6.666300296783447 10.6668004989624 Z M 1.999799966812134 10.6668004989624 L 0.9998999834060669 10.6668004989624 C 0.4485500156879425 10.6668004989624 0 10.2182502746582 0 9.666900634765625 L 0 7.667100429534912 C 0 7.115260124206543 0.4485500156879425 6.666300296783447 0.9998999834060669 6.666300296783447 L 1.999799966812134 6.666300296783447 C 2.55115008354187 6.666300296783447 2.99970006942749 7.115260124206543 2.99970006942749 7.667100429534912 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.2182502746582 2.55115008354187 10.6668004989624 1.999799966812134 10.6668004989624 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jeae9u =
    '<svg viewBox="0.3 9.0 381.5 469.8" ><defs><filter id="shadow"><feDropShadow dx="0" dy="5" stdDeviation="10"/></filter></defs><path transform="translate(0.25, 9.0)" d="M 16.93047332763672 0 L 364.5695190429688 0 C 373.9199829101562 0 381.5 10.33692646026611 381.5 23.08816719055176 L 381.5 446.6778869628906 C 381.5 459.4291076660156 373.9199829101562 469.7660522460938 364.5695190429688 469.7660522460938 L 16.93047332763672 469.7660522460938 C 7.580032348632812 469.7660522460938 0 459.4291076660156 0 446.6778869628906 L 0 23.08816719055176 C 0 10.33692646026611 7.580032348632812 0 16.93047332763672 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_u2r54 =
    '<svg viewBox="330.8 40.7 15.5 15.5" ><path transform="translate(327.45, 37.37)" d="M 3.375 11.1160888671875 C 3.375 15.39229583740234 6.839881896972656 18.857177734375 11.1160888671875 18.857177734375 C 15.39229583740234 18.857177734375 18.857177734375 15.39229583740234 18.857177734375 11.1160888671875 C 18.857177734375 6.839881896972656 15.39229583740234 3.375 11.1160888671875 3.375 C 6.839881420135498 3.375 3.375 6.839881896972656 3.375 11.1160888671875 Z M 14.13436889648438 9.500881195068359 C 14.41349411010742 9.221755027770996 14.87126159667969 9.221755027770996 15.15038681030273 9.500881195068359 C 15.29180908203125 9.642305374145508 15.35880088806152 9.824666976928711 15.35880088806152 10.00702857971191 C 15.35880088806152 10.18939208984375 15.28808784484863 10.37547492980957 15.14666366577148 10.51689910888672 L 11.63712310791016 14.0152759552002 C 11.35427474975586 14.27207183837891 10.91883850097656 14.26462936401367 10.64715766906738 13.99294662475586 L 7.085511684417725 10.44246482849121 C 6.806385517120361 10.16333961486816 6.802663803100586 9.709295272827148 7.085511684417725 9.426447868347168 C 7.36463737487793 9.147321701049805 7.818682193756104 9.143600463867188 8.101529121398926 9.426447868347168 L 11.11981010437012 12.47450065612793 L 14.13436889648438 9.500881195068359 Z" fill="#b7b7b7" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_w5lg9z =
    '<svg viewBox="1.0 1.0 25.4 28.2" ><path  d="M 13.6943302154541 19.02281379699707 C 11.18680858612061 19.02281379699707 8.99272632598877 21.06017684936523 8.99272632598877 23.72441673278809 L 8.99272632598877 28.89618110656738 L 8.992725372314453 29.20962333679199 L 1 29.20962333679199 L 1 11.65696907043457 L 13.6943302154541 1 C 13.6943302154541 1 26.3886604309082 11.65696907043457 26.3886604309082 11.65696907043457 L 26.3886604309082 29.20962333679199 L 18.39593505859375 29.20962333679199 L 18.23921394348145 28.89618110656738 L 18.23921394348145 23.72441482543945 C 18.39593505859375 21.06017684936523 16.20184898376465 19.02281379699707 13.6943302154541 19.02281379699707" fill="none" stroke="#4a5759" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_znb =
    '<svg viewBox="219.0 866.6 30.0 29.9" ><path transform="translate(210.04, 857.61)" d="M 37.09713745117188 22.03587532043457 L 25.83255004882812 22.03587532043457 L 25.83255004882812 10.82383441925049 C 25.83255004882812 9.801389694213867 24.99208068847656 8.96484375 23.96484375 8.96484375 C 22.93760681152344 8.96484375 22.09713745117188 9.801389694213867 22.09713745117188 10.82383441925049 L 22.09713745117188 22.03587532043457 L 10.83255004882812 22.03587532043457 C 9.805305480957031 22.03587532043457 8.96484375 22.87242317199707 8.96484375 23.89486694335938 C 8.96484375 24.40609359741211 9.174957275390625 24.87084007263184 9.513481140136719 25.2077808380127 C 9.851997375488281 25.54472351074219 10.31892395019531 25.75386047363281 10.83255004882812 25.75386047363281 L 22.09713745117188 25.75386047363281 L 22.09713745117188 36.96590042114258 C 22.09713745117188 37.47711944580078 22.3072509765625 37.94186782836914 22.64578247070312 38.27880859375 C 22.98429870605469 38.61575698852539 23.45122528076172 38.82489013671875 23.96484375 38.82489013671875 C 24.99208068847656 38.82489013671875 25.83255004882812 37.98834228515625 25.83255004882812 36.96590042114258 L 25.83255004882812 25.75386047363281 L 37.09713745117188 25.75386047363281 C 38.12437438964844 25.75386047363281 38.96484375 24.91731262207031 38.96484375 23.89486694335938 C 38.96484375 22.87242317199707 38.12437438964844 22.03587532043457 37.09713745117188 22.03587532043457 Z" fill="#4a5759" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hfkd7 =
    '<svg viewBox="-8.1 21.2 22.0 12.6" ><path transform="translate(-9.07, 10.74)" d="M 1 23.10021209716797 L 1 19.29084777832031 C 1 14.45588302612305 4.955879688262939 10.50000190734863 9.790844917297363 10.50000190734863 L 14.18626689910889 10.50000190734863 C 19.02123260498047 10.50000190734863 22.97711181640625 14.45588302612305 22.97711181640625 19.29084777832031 L 22.97711181640625 23.10021209716797" fill="none" stroke="#4a5759" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /></svg>';
