import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Services/google_api/application_bloc.dart';
import 'decisions_tree.dart';
import 'Views/mm_home_view.dart';
import 'Views/v_home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         builder: () => MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: DecisionsTree(),
//             ),       designSize: const Size(390, 844),
//
//     );
//
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () =>
          ChangeNotifierProvider(
              create: (context) => Applicationbloc(),
              child: MaterialApp(debugShowCheckedModeBanner: false, home: Map())),
      designSize: const Size(390, 844),
    );
  }

  // Widget map() {
  //   return Scaffold(
  //     body: ListView(
  //       children: [
  //         Text(
  //           "hi"
  //         ),
  //         Container(
  //           height: 200,
  //           child: GoogleMap(
  //             mapType: MapType.normal,
  //             myLocationEnabled: true,
  //             initialCameraPosition: CameraPosition(
  //                 target: LatLng(24.774265, 46.738586))
  //             ),
  //           ),
  //       ],
  //     )
  //   );
  // }
}

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Map();
  }
}

class _Map extends State<Map> {
  // static const _initialCameraPosition = CameraPosition(
  //   target: LatLng(37.773972, -122.431297),
  //   zoom: 11.5,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const TextField(
          decoration: InputDecoration(
            hintText: "Search",
                contentPadding: EdgeInsets.only(left: 10),
                hintStyle: TextStyle(

                )
          ),
        ),
        SizedBox(
          height: 200,
          child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(46.738586, 24.774265))),
        ),
        const ElevatedButton(
          onPressed: null,
          child: Text("hi"),
        )
      ],
    ));
  }
}
