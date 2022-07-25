import 'package:avatar_glow/avatar_glow.dart';
import 'package:dwr0001/Application/StationPage.dart';
import 'package:dwr0001/Application/burgerMenu/burgermenu.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/map_Service.dart';
import 'package:dwr0001/components/onwillpop.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";

class MapPage extends StatefulWidget {
  final List<StationModel> data;
  MapPage({Key key, this.data}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};
  // final mark = [
  //   LatLng(13.777183, 100.629559),
  //   LatLng(13.7785028, 100.6149977),
  //   LatLng(13.777694, 100.624656),
  // ];
  List mark = [];
  List result = [];

  Future<void> get_data() async {
    List<StationModel> snapshots = await get_dataMap();
    for (StationModel data in snapshots) {
      result.add(data);
    }
    for (StationModel item in result) {
      setState(
        () {
          _markers.add(
            Marker(
              width: 40,
              height: 40,
              point: LatLng(double.parse(item.LAT), double.parse(item.LON)),
              builder: (ctx) => Container(
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.white,
                //     width: 2,
                //   ),
                //   borderRadius: const BorderRadius.all(Radius.circular(40)),
                // ),
                child: InkWell(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AvatarGlow(
                        glowColor: Colors.blue,
                        endRadius: 100.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 200),
                        child: CircleAvatar(
                          radius: 18.0,
                          child: CircleAvatar(
                            radius: 0,
                            backgroundColor: Colors.greenAccent,
                          ),
                          backgroundColor: item.CURR_STATUS == "0"
                              ? Colors.green
                              : item.CURR_STATUS == "1"
                                  ? Colors.green
                                  : item.CURR_STATUS == "2"
                                      ? Colors.green
                                      : item.CURR_STATUS == "3"
                                          ? Colors.white
                                          : item.CURR_STATUS == "4"
                                              ? Colors.grey
                                              : item.CURR_STATUS == "5"
                                                  ? Colors.black
                                                  : Colors.green,
                        ),
                      ),
                      Text(
                        item.CURR_Acc_Rain_1_D,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onTap: () {
                    OnpressShow(item);
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.location_on_outlined),
                //   color: Color(0xff6200eee),
                //   iconSize: 45.0,
                //   onPressed: () {
                //     OnpressShow(item);
                //   },
                // ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<dynamic> OnpressShow(StationModel item) {
    return showModalBottomSheet(
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) {
        return InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StationPage(
                  stn_id: item.STN_ID,
                  basinID: 4,
                  RF: item.RF,
                  WL: item.WL,
                  CCTV: item.CURR_CCTV,
                  data: widget.data,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, bottom: 30),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 3,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: AvatarGlow(
                        glowColor: Colors.blue,
                        endRadius: 40.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 200),
                        child: CircleAvatar(
                          radius: 18.0,
                          child: CircleAvatar(
                            radius: 0,
                            backgroundColor: Colors.greenAccent,
                          ),
                          backgroundColor: item.CURR_STATUS == "0"
                              ? Colors.green
                              : item.CURR_STATUS == "1"
                                  ? Colors.green
                                  : item.CURR_STATUS == "2"
                                      ? Colors.green
                                      : item.CURR_STATUS == "3"
                                          ? Colors.white
                                          : item.CURR_STATUS == "4"
                                              ? Colors.grey
                                              : item.CURR_STATUS == "5"
                                                  ? Colors.black
                                                  : Colors.green,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.STN_Name),
                        Text(item.LAST_UPDATE),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        drawer: NavigationBurgerMenuWidget(data: widget.data),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          centerTitle: true,
          title: Text(
            'แผนที่',
            style: DefaultTitleW(),
          ),
          backgroundColor: Colors.lightBlue[600],
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(17.1408165, 103.4063071),
            // กรุงเทพ LatLng(13.782694, 100.5549202),
            zoom: 8,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayerOptions(markers: _markers.toList())
          ],
        ),
      ),
    );
  }
}
