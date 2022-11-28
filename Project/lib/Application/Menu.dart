import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dwr0001/Application/Station/TabOneStation.dart';
import 'package:dwr0001/Application/StationPage.dart';
import 'package:dwr0001/Application/burgerMenu/burgermenu.dart';
import 'package:dwr0001/Application/forecast/forecast.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/basinInfoModel.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/BoxDetail.dart';
import 'package:dwr0001/components/onwillpop.dart';
import 'package:dwr0001/components/switchColor.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  final List<StationModel> data;

  MenuPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  DateTime backbuttonpressedTime;
  int optionSelected = 1;
  int SelectRiver = 1;
  List<StationModel> newResult = [];
  var alreadyFavorite;

  bool isVisible = false;
  bool isCheckVisible = false;
  bool check = false;
  List<StationModel> Listnotify = [];
  List<StationModel> ListnotifyStream = [];
  List<BasinsInfoModel> infoBasin = [];
  String Project_URL = "https://tele-maeklong.dwr.go.th/home/INFO_PROJECT";
  String Forecast_URL = "https://tele-maeklong.dwr.go.th/fs/forecast.php";

  StreamController<StationModel> _streamControllerNoti = StreamController();
  TabController _tabController;

  void checkOption(int index) {
    setState(() {
      selectInfoBasin(index);
      optionSelected = index;
    });
  }

  void getInfobasin() async {
    infoBasin = await basinInfoData();
  }

  void selectInfoBasin(int basin) {
    switch (basin) {
      case 1:
        {
          Project_URL = infoBasin[0].projectUrl;
          Forecast_URL = infoBasin[0].forecastUrl;
          setState(() {});
          break;
        }
      case 2:
        {
          Project_URL = infoBasin[1].projectUrl;
          Forecast_URL = infoBasin[1].forecastUrl;

          setState(() {});
          break;
        }
      case 3:
        {
          Project_URL = infoBasin[2].projectUrl;
          Forecast_URL = infoBasin[2].forecastUrl;

          setState(() {});
          break;
        }
      case 4:
        {
          Project_URL = infoBasin[3].projectUrl;
          Forecast_URL = infoBasin[3].forecastUrl;

          setState(() {});
          break;
        }
      case 5:
        {
          Project_URL = infoBasin[4].projectUrl;
          Forecast_URL = infoBasin[4].forecastUrl;

          setState(() {});
          break;
        }
      case 6:
        {
          Project_URL = infoBasin[5].projectUrl;
          Forecast_URL = infoBasin[5].forecastUrl;

          setState(() {});
          break;
        }
      case 7:
        {
          Project_URL = infoBasin[6].projectUrl;
          Forecast_URL = infoBasin[6].forecastUrl;

          setState(() {});
          break;
        }
    }
  }

  void Notification() async {
    if (!_streamControllerNoti.isClosed) {
      Listnotify = await getNotification();
      setState(() {});
    }
  }

  @override
  void initState() {
    if (!_streamControllerNoti.isClosed) {
      Timer.periodic(Duration(seconds: 5), (timer) {
        Notification();
      });
    }
    _tabController = TabController(length: 2, vsync: this);
    getInfobasin();
    super.initState();
  }

  @override
  void dispose() {
    _streamControllerNoti.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<FavoriteRiver>(
      builder: (context, Data, _) {
        if (Data.favorite.length > 0) {
          if (newResult.length == 0) {
            isVisible = !isVisible;
          }
        }
        return Consumer<NotificationRiver>(
          builder: (context, Noti, _) {
            if (Noti.Notification.length == 0) {
              Noti.addData(Listnotify);
            } else {
              if (Listnotify.length != 0) {
                Noti.addData(Listnotify);
              }
            }
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
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    'TeleDWR',
                    style: DefaultTitleW(),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: MySearchDelegate(widget.data),
                        );
                      },
                    )
                  ],
                  backgroundColor: Colors.lightBlue[600],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Header(),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      // color: Colors.lightBlue[600],
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 1,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: TabBar(
                                            indicatorPadding: EdgeInsets.all(2),
                                            indicator: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5,
                                              ),
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                            indicatorColor: Colors.grey,
                                            labelColor: Colors.black,
                                            onTap: (index) {
                                              if (index == 0) {
                                                if (newResult.length != 0) {
                                                  setState(() {
                                                    isVisible = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isVisible = false;
                                                  });
                                                }
                                              } else {
                                                if (Noti.Notification.length !=
                                                    0) {
                                                  setState(() {
                                                    isVisible = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isVisible = false;
                                                  });
                                                }
                                              }
                                            },
                                            labelStyle: favoriteStyle(),
                                            isScrollable: true,
                                            controller: _tabController,
                                            tabs: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star_outline,
                                                    size: 18,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    child: Tab(
                                                      text: "ติดตาม",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .notifications_active_outlined,
                                                    size: 18,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    child:
                                                        Tab(text: "แจ้งเตือน"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Icon(
                                            !isVisible
                                                ? Icons
                                                    .arrow_drop_down_circle_outlined
                                                : Icons.arrow_drop_up_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isVisible,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        FadeInDown(
                                          from: 0,
                                          child: Consumer<FavoriteRiver>(
                                              builder: (context, Data, _) {
                                            for (var result in widget.data) {
                                              alreadyFavorite = Data.favorite
                                                  .contains(result.STN_ID);
                                              if (alreadyFavorite) {
                                                for (var i = 0;
                                                    i < newResult.length;
                                                    i++) {
                                                  check = newResult[i]
                                                      .STN_ID
                                                      .contains(result.STN_ID);
                                                  if (check) {
                                                    break;
                                                  }
                                                }
                                                if (check == false) {
                                                  newResult.add(
                                                    StationModel(
                                                      STN_ID: result.STN_ID,
                                                      STN_Name: result.STN_Name,
                                                      RF: result.RF,
                                                      WL: result.WL,
                                                      BASINID: result.BASINID,
                                                      CURR_CCTV:
                                                          result.CURR_CCTV,
                                                      CURR_STATUS:
                                                          result.CURR_STATUS,
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                            final List<StationModel> station =
                                                newResult;
                                            return Visibility(
                                              visible: isVisible,
                                              child: Container(
                                                width: double.infinity,
                                                color: Colors.black12,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 200,
                                                      child: resultData(
                                                          station, widget.data),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                        FadeInDown(
                                          from: 0,
                                          child: Consumer<NotificationRiver>(
                                            builder: (context, Noti, _) {
                                              return Container(
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      Noti.Notification.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var lastUpdate = Noti
                                                        .Notification[index]
                                                        .LAST_UPDATE
                                                        .split(" ");
                                                    var time = lastUpdate[1]
                                                        .split(":");
                                                    return GestureDetector(
                                                      onTap: () {
                                                        print(index);
                                                      },
                                                      child: ListTile(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                right: 0),
                                                        leading: Container(
                                                          child: AvatarGlow(
                                                            glowColor:
                                                                Colors.blue,
                                                            endRadius: 30.0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    2000),
                                                            repeat: true,
                                                            showTwoGlows: true,
                                                            repeatPauseDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        200),
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Noti.Notification[index]
                                                                            .RF ==
                                                                        "RF"
                                                                    ? Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                blurRadius: 1,
                                                                                color: Colors.grey,
                                                                                spreadRadius: 1)
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              18.0,
                                                                          backgroundColor: swColor.switchColor(Noti
                                                                              .Notification[index]
                                                                              .CURR_STATUS),
                                                                        ),
                                                                      )
                                                                    : CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius:
                                                                            18.0,
                                                                      ),
                                                                Noti.Notification[index]
                                                                            .WL ==
                                                                        "WL"
                                                                    ? Positioned(
                                                                        bottom: Noti.Notification[index].CURR_STATUS_WL == "6" ||
                                                                                Noti.Notification[index].CURR_STATUS_WL == "7"
                                                                            ? null
                                                                            : 8,
                                                                        top: Noti.Notification[index].CURR_STATUS_WL == "6" ||
                                                                                Noti.Notification[index].CURR_STATUS_WL == "7"
                                                                            ? 8
                                                                            : null,
                                                                        child:
                                                                            Container(
                                                                          child: Noti.Notification[index].CURR_STATUS_WL == "6" || Noti.Notification[index].CURR_STATUS_WL == "7"
                                                                              ? CustomPaint(
                                                                                  painter: TrianglePainter(
                                                                                    strokeColor: Noti.Notification[index].CURR_STATUS_WL == "6"
                                                                                        ? Color.fromARGB(255, 240, 220, 40)
                                                                                        : Noti.Notification[index].CURR_STATUS_WL == "7"
                                                                                            ? Color.fromARGB(255, 183, 25, 14)
                                                                                            : swColor.switchColor(Noti.Notification[index].CURR_STATUS),
                                                                                    strokeWidth: 10,
                                                                                    paintingStyle: PaintingStyle.fill,
                                                                                    angle: 0,
                                                                                  ),
                                                                                  child: Container(
                                                                                    height: 28,
                                                                                    width: 30,
                                                                                  ),
                                                                                )
                                                                              : CustomPaint(
                                                                                  painter: TrianglePainter(
                                                                                    strokeColor: Noti.Notification[index].CURR_STATUS_WL == "0"
                                                                                        ? Color.fromARGB(255, 35, 119, 36)
                                                                                        : Noti.Notification[index].CURR_STATUS_WL == "1"
                                                                                            ? Color.fromARGB(255, 240, 220, 40)
                                                                                            : Noti.Notification[index].CURR_STATUS_WL == "2"
                                                                                                ? Colors.red
                                                                                                : Noti.Notification[index].CURR_STATUS_WL == "3"
                                                                                                    ? Noti.Notification[index].CURR_STATUS == "3"
                                                                                                        ? Colors.grey
                                                                                                        : Colors.white
                                                                                                    : Noti.Notification[index].CURR_STATUS_WL == "4"
                                                                                                        ? Noti.Notification[index].CURR_STATUS == "4"
                                                                                                            ? Color.fromARGB(255, 200, 200, 200)
                                                                                                            : Colors.grey
                                                                                                        : Noti.Notification[index].CURR_STATUS == "5"
                                                                                                            ? Color.fromARGB(255, 108, 108, 108)
                                                                                                            : Colors.black,
                                                                                    strokeWidth: 1,
                                                                                    paintingStyle: Noti.Notification[index].CURR_STATUS_WL == "3"
                                                                                        ? Noti.Notification[index].CURR_STATUS == "3"
                                                                                            ? PaintingStyle.stroke
                                                                                            : PaintingStyle.fill
                                                                                        : Noti.Notification[index].CURR_STATUS_WL == "4"
                                                                                            ? Noti.Notification[index].CURR_STATUS == "4"
                                                                                                ? PaintingStyle.stroke
                                                                                                : PaintingStyle.fill
                                                                                            : Noti.Notification[index].CURR_STATUS_WL == "5"
                                                                                                ? Noti.Notification[index].CURR_STATUS == "5"
                                                                                                    ? PaintingStyle.stroke
                                                                                                    : PaintingStyle.fill
                                                                                                : PaintingStyle.fill,
                                                                                    angle: 1,
                                                                                  ),
                                                                                  child: Container(
                                                                                    height: 28,
                                                                                    width: 30,
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        title: new Text(
                                                          Noti
                                                              .Notification[
                                                                  index]
                                                              .STN_ID,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontFamily: 'Kanit',
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        subtitle: new Text(
                                                          Noti
                                                              .Notification[
                                                                  index]
                                                              .STN_Name,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontFamily: 'Kanit',
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        ),
                                                        trailing: Wrap(
                                                          spacing:
                                                              2, // space between two icons
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          15.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            2.0),
                                                                    child: Text(
                                                                      time[0] +
                                                                          ":" +
                                                                          time[
                                                                              1],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            'Kanit',
                                                                        fontSize:
                                                                            12.0,
                                                                        fontWeight:
                                                                            FontWeight.w200,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    lastUpdate[
                                                                        0],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      fontSize:
                                                                          10.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              // color: Colors.red,
                                                              child: Icon(Icons
                                                                  .arrow_forward_ios),
                                                            ), // icon-2
                                                          ],
                                                        ),
                                                        onTap: () {
                                                          // await FlutterSession().set('river', basinID.toString());
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                Divider(color: Colors.black38),
                                // Text(
                                //   "TeleDWR-รายการสถานี",
                                //   style: DefaultStyleB(),
                                // ),
                                SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      SelectRiver == 1
                                          ? "ลุ่มแม่น้ำกลอง"
                                          : SelectRiver == 2
                                              ? "ลุ่มน้ำสาละวิน"
                                              : SelectRiver == 3
                                                  ? "ลุ่มน้ำกกและโขงเหนือ"
                                                  : SelectRiver == 4
                                                      ? "ลุ่มน้ำสงครามและห้วยหลวง"
                                                      : SelectRiver == 5
                                                          ? "ลุ่มน้ำบางปะกง"
                                                          : SelectRiver == 6
                                                              ? "อำเภอบางสะพาน"
                                                              : SelectRiver == 7
                                                                  ? "จังหวัดนครศรีธรรมราช"
                                                                  : "ไม่พบข้อมูล",
                                      style: DefaultStyleB(),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      BoxDetail(
                                        title: "เกี่ยวกับโครงการ",
                                        checkFound: Project_URL,
                                        path: ForecastPage(
                                          title: "เกี่ยวกับโครงการ",
                                          URL: Project_URL,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      BoxDetail(
                                        title: "การคาดการณ์",
                                        checkFound: Forecast_URL,
                                        path: ForecastPage(
                                          title: "การคาดการณ์",
                                          URL: Forecast_URL,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.60,
                                  width: double.infinity,
                                  child:
                                      TabOneStation(SelectRiver, widget.data),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Container Header() {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("เลือกลุ่มแม่น้ำ", style: SelectMenuStyle()),
            SizedBox(height: 5),
            Container(
              height: 100,
              child: GridView(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: [
                  for (int i = 0; i < ListRiver.items.length; i++)
                    InkWell(
                      child: Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/river.png"),
                            fit: BoxFit.cover,
                          ),
                          color: optionSelected == i + 1
                              ? Colors.lightBlue[600]
                              : Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        width: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ListRiver.items[i]['page'] == 6 ||
                                        ListRiver.items[i]['page'] == 7
                                    ? ""
                                    : "ลุ่มน้ำ",
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w200,
                                    color: optionSelected == i + 1
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ListRiver.items[i]['title'],
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: TextStyle(
                                        shadows: <Shadow>[
                                          // Shadow(
                                          //   offset: Offset(1, 2.0),
                                          //   blurRadius: 3.0,
                                          //   color: Colors.white,
                                          // ),
                                        ],
                                        fontFamily: 'Kanit',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w200,
                                        color: optionSelected == i + 1
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          SelectRiver = ListRiver.items[i]['page'];
                        });
                        checkOption(i + 1);
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView resultData(List<StationModel> station, List<StationModel> data) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: station.length,
      itemBuilder: (context, int i) =>
          Consumer<FavoriteRiver>(builder: (context, Data, _) {
        final alreadyFavorite = Data.favorite.contains(station[i].STN_ID);
        return Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 10,
            left: 10,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationPage(
                      stnId: station[i].STN_ID,
                      basinID: station[i].BASINID,
                      RF: station[i].RF,
                      WL: station[i].WL,
                      CCTV: station[i].CURR_CCTV,
                      data: data),
                ),
              );
            },
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (alreadyFavorite) {
                                // Data.addData(station[i].STN_ID);
                                Data.removeData(station[i].STN_ID);
                                station.remove(station[i]);
                              }
                            });
                          },
                          child: Icon(
                            alreadyFavorite
                                ? Icons.star_outlined
                                : Icons.star_border_outlined,
                            color: alreadyFavorite ? Colors.yellow : null,
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: AvatarGlow(
                        glowColor: Colors.blue,
                        endRadius: 20.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 200),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            station[i].RF == "RF"
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            color: Colors.grey,
                                            spreadRadius: 1)
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 18.0,
                                      backgroundColor: swColor
                                          .switchColor(station[i].CURR_STATUS),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 18.0,
                                  ),
                            station[i].WL == "WL"
                                ? Positioned(
                                    bottom: station[i].CURR_STATUS_WL == "6" ||
                                            station[i].CURR_STATUS_WL == "7"
                                        ? null
                                        : 8,
                                    top: station[i].CURR_STATUS_WL == "6" ||
                                            station[i].CURR_STATUS_WL == "7"
                                        ? 8
                                        : null,
                                    child: Container(
                                      child: station[i].CURR_STATUS_WL == "6" ||
                                              station[i].CURR_STATUS_WL == "7"
                                          ? CustomPaint(
                                              painter: TrianglePainter(
                                                strokeColor: station[i]
                                                            .CURR_STATUS_WL ==
                                                        "6"
                                                    ? Color.fromARGB(
                                                        255, 240, 220, 40)
                                                    : station[i].CURR_STATUS_WL ==
                                                            "7"
                                                        ? Color.fromARGB(
                                                            255, 183, 25, 14)
                                                        : swColor.switchColor(
                                                            station[i]
                                                                .CURR_STATUS),
                                                strokeWidth: 10,
                                                paintingStyle:
                                                    PaintingStyle.fill,
                                                angle: 0,
                                              ),
                                              child: Container(
                                                height: 28,
                                                width: 30,
                                              ),
                                            )
                                          : CustomPaint(
                                              painter: TrianglePainter(
                                                strokeColor: station[i]
                                                            .CURR_STATUS_WL ==
                                                        "0"
                                                    ? Color.fromARGB(
                                                        255, 35, 119, 36)
                                                    : station[i].CURR_STATUS_WL ==
                                                            "1"
                                                        ? Color.fromARGB(
                                                            255, 240, 220, 40)
                                                        : station[i].CURR_STATUS_WL ==
                                                                "2"
                                                            ? Colors.red
                                                            : station[i].CURR_STATUS_WL ==
                                                                    "3"
                                                                ? station[i].CURR_STATUS ==
                                                                        "3"
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .white
                                                                : station[i].CURR_STATUS_WL ==
                                                                        "4"
                                                                    ? station[i].CURR_STATUS ==
                                                                            "4"
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            200,
                                                                            200,
                                                                            200)
                                                                        : Colors
                                                                            .grey
                                                                    : station[i].CURR_STATUS ==
                                                                            "5"
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            108,
                                                                            108,
                                                                            108)
                                                                        : Colors
                                                                            .black,
                                                strokeWidth: 1,
                                                paintingStyle: station[i]
                                                            .CURR_STATUS_WL ==
                                                        "3"
                                                    ? station[i].CURR_STATUS ==
                                                            "3"
                                                        ? PaintingStyle.stroke
                                                        : PaintingStyle.fill
                                                    : station[i].CURR_STATUS_WL ==
                                                            "4"
                                                        ? station[i].CURR_STATUS ==
                                                                "4"
                                                            ? PaintingStyle
                                                                .stroke
                                                            : PaintingStyle.fill
                                                        : station[i].CURR_STATUS_WL ==
                                                                "5"
                                                            ? station[i].CURR_STATUS ==
                                                                    "5"
                                                                ? PaintingStyle
                                                                    .stroke
                                                                : PaintingStyle
                                                                    .fill
                                                            : PaintingStyle
                                                                .fill,
                                                angle: 1,
                                              ),
                                              child: Container(
                                                height: 28,
                                                width: 30,
                                              ),
                                            ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      station[i].STN_ID,
                      style: FavoriteStyle(),
                    ),
                    Text(
                      station[i].STN_Name,
                      style: FavoriteStyle(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    // Divider(
                    //   color: Colors.black.withOpacity(0.2),
                    //   thickness: 1,
                    // ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.water),
                    //   ],
                    // ),
                    Text(
                      "ปริมาณน้ำฝน",
                      style: FavoriteStyle(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      "${station[i].CURR_Acc_Rain_15_M == null ? "0.0" : station[i].CURR_Acc_Rain_15_M} มม.",
                      style: FavoriteStyle(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      "ระดับน้ำ",
                      style: FavoriteStyle(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      "${station[i].CURR_Water_D_Level_MSL == null ? "0.0" : station[i].CURR_Water_D_Level_MSL} ม.รทก.",
                      style: FavoriteStyle(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate(this.dataserach);
  List<StationModel> dataserach;

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        )
      ];
  @override
  Widget buildResults(BuildContext context) {
    if (dataserach.length == 0) {
      dataserach = [];
    }
    if (query != null) {
      List<StationModel> suggestions = dataserach.where((dataserach) {
        final result =
            dataserach.STN_ID.toLowerCase() + dataserach.STN_Name.toLowerCase();
        final input = query.toLowerCase();

        return result.contains(input);
      }).toList();
      return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final StationModel suggestion = suggestions[index];

            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StationPage(
                        stnId: suggestion.STN_ID,
                        basinID: suggestion.BASINID,
                        RF: suggestion.RF,
                        WL: suggestion.WL,
                        CCTV: suggestion.CURR_CCTV,
                        data: dataserach),
                  ),
                );
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Ink(
                      child: new ListTile(
                    leading: Container(
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
                          backgroundColor: suggestion.CURR_STATUS == "0"
                              ? Colors.green
                              : suggestion.CURR_STATUS == "1"
                                  ? Colors.green
                                  : suggestion.CURR_STATUS == "2"
                                      ? Colors.green
                                      : suggestion.CURR_STATUS == "3"
                                          ? Colors.white
                                          : suggestion.CURR_STATUS == "4"
                                              ? Colors.grey
                                              : suggestion.CURR_STATUS == "5"
                                                  ? Colors.black
                                                  : Colors.green,
                        ),
                      ),
                    ),
                    title: new Text(
                      suggestion.STN_ID,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Kanit',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                    ),
                    subtitle: new Text(
                      suggestion.STN_Name,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Kanit',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w200),
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        Image.asset(
                          suggestion.CURR_STATUS == "0"
                              ? 'assets/banner/bell/green.png'
                              : suggestion.CURR_STATUS == "1"
                                  ? "assets/banner/bell/yellow.png"
                                  : suggestion.CURR_STATUS == "2"
                                      ? "assets/banner/bell/red.png"
                                      : suggestion.CURR_STATUS == "3"
                                          ? "assets/banner/bell/gray.png"
                                          : suggestion.CURR_STATUS == "4"
                                              ? "assets/banner/bell/gray.png"
                                              : suggestion.CURR_STATUS == "5"
                                                  ? "assets/banner/bell/gray.png"
                                                  : "",
                          height: 45,
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  )),
                ],
              ),
            );
          });
    } else {
      return ListTile(title: Text("ไม่พบข้อมูล"));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StationModel> suggestions = dataserach.where((dataserach) {
      final result = dataserach.STN_ID.toLowerCase() +
          " " +
          dataserach.STN_Name.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final StationModel suggestion = suggestions[index];

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationPage(
                      stnId: suggestion.STN_ID,
                      basinID: suggestion.BASINID,
                      RF: suggestion.RF,
                      WL: suggestion.WL,
                      CCTV: suggestion.CURR_CCTV,
                      data: dataserach),
                ),
              );
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Ink(
                    child: new ListTile(
                  leading: Container(
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
                        backgroundColor: suggestion.CURR_STATUS == "0"
                            ? Colors.green
                            : suggestion.CURR_STATUS == "1"
                                ? Colors.green
                                : suggestion.CURR_STATUS == "2"
                                    ? Colors.green
                                    : suggestion.CURR_STATUS == "3"
                                        ? Colors.white
                                        : suggestion.CURR_STATUS == "4"
                                            ? Colors.grey
                                            : suggestion.CURR_STATUS == "5"
                                                ? Colors.black
                                                : Colors.green,
                      ),
                    ),
                  ),
                  title: new Text(
                    suggestion.STN_ID,
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Kanit',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: new Text(
                    suggestion.STN_Name,
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Kanit',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w200),
                  ),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      Image.asset(
                        suggestion.CURR_STATUS == "0"
                            ? 'assets/banner/bell/green.png'
                            : suggestion.CURR_STATUS == "1"
                                ? "assets/banner/bell/yellow.png"
                                : suggestion.CURR_STATUS == "2"
                                    ? "assets/banner/bell/red.png"
                                    : suggestion.CURR_STATUS == "3"
                                        ? "assets/banner/bell/gray.png"
                                        : suggestion.CURR_STATUS == "4"
                                            ? "assets/banner/bell/gray.png"
                                            : suggestion.CURR_STATUS == "5"
                                                ? "assets/banner/bell/gray.png"
                                                : "",
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          );
        });
  }
}
