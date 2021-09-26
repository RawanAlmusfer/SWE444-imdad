import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/post_request_form.dart';
import 'mm_home_view.dart';

class PostRequest extends StatefulWidget {
  PostRequest.ensureInitialized();
  const PostRequest({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PostRequestState();
  }}

class _PostRequestState extends State<PostRequest> {
  final List<Widget> _children = [
    mmHome(),
    PostRequest(),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    bool portrait = true;

    if (deviceOrientation == Orientation.landscape) portrait = false;

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      // appBar: AppBar(
      //   title: Text(
      //     "إضافة طلب جديد",
      //     style: TextStyle(
      //       color: const Color(0xff334856),
      //       fontWeight: FontWeight.w700,
      //       fontFamily: 'Tajawal',
      //       fontSize: 24,
      //     ),
      //   ),
      //   backgroundColor: const Color(0xdeedd03c),
      //   bottomOpacity: 30,
      //   // elevation: 1,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(50),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              Text(
                'نموذج إضافة طلب جديد',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff334856),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: portrait == true ? 15.h : 20.h),
              Container(
                height: portrait == true ? 520.h : 980.h,
                width: portrait == true ? 330.w : 280.w,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffffffff),
                  border:
                      Border.all(width: 0.5, color: const Color(0xffdfdfdf)),
                ),
                child: PostRequestForm(),
              ),
              SizedBox(height: portrait == true ? 0.h : 230.h),
            ],
          ),
        ),
      ),

    );
  }

}
