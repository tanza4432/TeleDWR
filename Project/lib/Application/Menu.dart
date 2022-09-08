import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dwr0001/Application/Station/TabOneStation.dart';
import 'package:dwr0001/Application/StationPage.dart';
import 'package:dwr0001/Application/burgerMenu/burgermenu.dart';
import 'package:dwr0001/Application/forecast/forecast.dart';
import 'package:dwr0001/Application/pdf/PdfViewer.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/components/BoxDetail.dart';
import 'package:dwr0001/components/onwillpop.dart';
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

class _MenuPageState extends State<MenuPage> {
  List<Map<String, dynamic>> items = <Map<String, dynamic>>[
    <String, dynamic>{'title': "ลุ่มน้ำบางปะกง", 'page': 5},
    <String, dynamic>{'title': "ลุ่มน้ำแม่กลอง", 'page': 1},
    <String, dynamic>{'title': "ลุ่มน้ำสาละวิน", 'page': 2},
    <String, dynamic>{'title': "ลุ่มน้ำกกและโขงเหนือ", 'page': 3},
    <String, dynamic>{'title': "ลุ่มน้ำสงครามและห้วยหลวง", 'page': 4},
    <String, dynamic>{'title': "อำเภอบางสะพาน", 'page': 6},
    <String, dynamic>{'title': "จังหวัดนครศรีธรรมราช", 'page': 7},
  ];

  DateTime backbuttonpressedTime;
  int optionSelected = 1;
  int SelectRiver = 0;
  List<StationModel> newResult = [];
  var alreadyFavorite;

  bool isVisible = false;
  bool isCheckVisible = false;
  bool check = false;

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  void initState() {
    super.initState();
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              centerTitle: true,
              title: Text(
                'หน้าหลัก',
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
                                  color: Colors.lightBlue[600],
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 3,
                                      color: Colors.lightBlue[600],
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "ติดตามสถานี",
                                        style: DefaultStyleW(),
                                      ),
                                      Icon(
                                        !isVisible
                                            ? Icons
                                                .arrow_drop_down_circle_outlined
                                            : Icons.arrow_drop_up_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeInDown(
                              from: 0,
                              child: Consumer<FavoriteRiver>(
                                  builder: (context, Data, _) {
                                for (var result in widget.data) {
                                  alreadyFavorite =
                                      Data.favorite.contains(result.STN_ID);
                                  if (alreadyFavorite) {
                                    for (var i = 0; i < newResult.length; i++) {
                                      check = newResult[i]
                                          .STN_ID
                                          .contains(result.STN_ID);
                                      if (check) {
                                        break;
                                      }
                                    }
                                    if (check == false) {
                                      print(result.BASINID);
                                      newResult.add(
                                        StationModel(
                                          STN_ID: result.STN_ID,
                                          STN_Name: result.STN_Name,
                                          RF: result.RF,
                                          WL: result.WL,
                                          BASINID: result.BASINID,
                                          CURR_CCTV: result.CURR_CCTV,
                                          CURR_STATUS: result.CURR_STATUS,
                                        ),
                                      );
                                    }
                                  }
                                }
                                final List<StationModel> station = newResult;
                                return Visibility(
                                  visible: isVisible,
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.black12,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          child:
                                              resultData(station, widget.data),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 10, bottom: 10),
                            //   child: Row(
                            //     children: [
                            //       BoxDetail(
                            //         title: "เกี่ยวกับโครงการ",
                            //         path: PdfViewer(
                            //             basinID: optionSelected,
                            //             data: widget.data),
                            //       ),
                            //       SizedBox(width: 20),
                            //       BoxDetail(
                            //         title: "การคาดการณ์",
                            //         path: ForecastPage(
                            //             basinID: optionSelected,
                            //             data: widget.data),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Divider(color: Colors.black38),
                            Text(
                              "TeleDWR-รายการสถานี",
                              style: DefaultStyleB(),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.lightBlue[600],
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 3,
                                    color: Colors.lightBlue[600],
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
                                  style: DefaultStyleW(),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.60,
                              width: double.infinity,
                              color: Colors.white,
                              child: TabOneStation(SelectRiver, widget.data),
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
            Text("เลือกลุ่มแม่น้ำ", style: DefaultStyleB()),
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
                  for (int i = 0; i < items.length; i++)
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: optionSelected == i + 1
                              ? Colors.lightBlue[600]
                              : Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            items[i]['title'],
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w200,
                                color: optionSelected == i + 1
                                    ? Colors.white
                                    : Colors.black54),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          SelectRiver = items[i]['page'];
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StationPage(
                      stn_id: station[i].STN_ID,
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
                padding: const EdgeInsets.all(10.0),
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
                          backgroundColor: station[i].CURR_STATUS == "0"
                              ? Colors.green
                              : station[i].CURR_STATUS == "1"
                                  ? Colors.green
                                  : station[i].CURR_STATUS == "2"
                                      ? Colors.green
                                      : station[i].CURR_STATUS == "3"
                                          ? Colors.white
                                          : station[i].CURR_STATUS == "4"
                                              ? Colors.grey
                                              : station[i].CURR_STATUS == "5"
                                                  ? Colors.black
                                                  : Colors.green,
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
                        stn_id: suggestion.STN_ID,
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
                      stn_id: suggestion.STN_ID,
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
  }
}
