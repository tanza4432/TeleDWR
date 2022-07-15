// import 'dart:convert';
// import 'package:dwr0001/Application/Station/TabOneStation.dart';
// import 'package:http/http.dart' as http;
// import 'package:dwr0001/Models/station_model.dart';
// import 'package:flutter/material.dart';
// import 'Station/TabTwoStation.dart';

// class OverViewPage extends StatelessWidget {
//   OverViewPage(this.basinID);
//   var basinID;
//   @override
//   Widget build(BuildContext context) {
//     var materialApp = MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DefaultTabController(
//         length: 2,
//         child: MyDisplayClass(basinID),
//       ),
//     );
//     return materialApp;
//   }
// }

// class MyDisplayClass extends StatelessWidget {
//   MyDisplayClass(this.basinID);
//   var basinID;
//   @override
//   Widget build(BuildContext context) {
//     print(basinID);
//     return Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           tabs: [
//             Tab(
//               icon: Icon(Icons.star_border),
//               text: "ภาพรวมสถานี",
//             ),
//             Tab(
//               icon: Icon(Icons.add_alert),
//               text: "การแจ้งเตือน",
//             ),
//           ],
//         ),
//         title: Text(
//           'TELEDWR-รายการสถานี',
//           style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Kanit',
//               fontSize: 18.0,
//               fontWeight: FontWeight.w700),
//         ),
//         elevation: 10.0,
//         automaticallyImplyLeading: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () => {
//             // Navigator.push(context,
//             //     MaterialPageRoute(builder: (context) => StationOld(basinID)))
//           },
//         ),
//       ),
//       body: WillPopScope(
//         child: TabBarView(
//           children: [
//             // TabOneStation(basinID),
//             TabTwoStation(basinID),
//           ],
//         ),
//       ),
//     );
//   }

//   noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }


