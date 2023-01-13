import 'dart:convert';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/dataOffline_Model.dart';
import 'package:dwr0001/Models/data_Model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:intl/intl.dart';

class TabTwo extends StatelessWidget {
  TabTwo(this.stnId, this.title, this.wl, this.rf);
  var stnId;
  String title;
  String wl;
  String rf;
  List<DataModelGet> resultOffline = [];
  bool check = false;
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  Widget build(BuildContext context) {
    List<DataModelGet> data = [];
    var resultData;
    return Consumer<RiverProviderTabTwo>(
      builder: (context, Data, _) => FutureBuilder<List<DataModelGet>>(
          future: getStationData24H(stnId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (Data.dataRiver.length != 0) {
                for (var i in Data.dataRiver) {
                  if (i.stnId == stnId) {
                    data = i.data;
                    return TabTwoDetail(context, data);
                  }
                }
                if (snapshot.data == null) {
                  return LoadingSquareCircle();
                }
              } else {
                return LoadingSquareCircle();
              }
            } else if (snapshot.hasData) {
              // print(jsonEncode(snapshot.data));

              data = snapshot.data;
              data.sort((b, a) => a.Label.compareTo(b.Label));
              resultData = DataStnIdModelGet(stnId: stnId, data: data);
              if (Data.dataRiver.length == 0) {
                Data.addData(resultData);
              } else {
                for (var i in Data.dataRiver) {
                  if (i.stnId == stnId) {
                    check = true;
                    break;
                  }
                }
                if (check == false) {
                  Data.addData(resultData);
                }
              }
              return TabTwoDetail(context, data);
            }
            return LoadingSquareCircle();
          }),
    );
  }

  SingleChildScrollView TabTwoDetail(
      BuildContext context, List<DataModelGet> data) {
    bool notFound = false;
    if (data.length == 0) {
      notFound = true;
    }
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            color: Colors.lightBlue[700],
            child: Row(
              children: [
                Icon(Icons.location_on_outlined),
                Flexible(
                  child: Text(
                    "สถานี : " + stnId + " " + title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Kanit',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          notFound
              ? Container(
                  height: size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่พบข้อมูล",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Colors.black45),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: double.infinity,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      return null; // Use the default value.
                    }),
                    columnSpacing: 0.0,
                    columns: [
                      DataColumn(
                          label: Text("วันที่/เวลา",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                          numeric: false,
                          onSort: (i, b) {}),
                      DataColumn(
                          label: Text("ปริมาณฝน\r\n(มม.)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.bold,
                              )),
                          numeric: false,
                          onSort: (i, b) {}),
                      DataColumn(
                          label: Text("ระดับน้ำ\r\n(ม.รทก.)",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                          numeric: false,
                          onSort: (i, b) {}),
                      DataColumn(
                          label: Text("ปริมาณน้ำ\r\n(ลบ.ม./วิ)",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                          numeric: false,
                          onSort: (i, b) {})
                    ],
                    rows: data.map(
                      (data_) {
                        var format = NumberFormat.currency(locale: 'en_CH')
                            .format(double.parse(data_.Flow));
                        var dataresult = format.split("USD");
                        data_.Flow = dataresult[1];
                        return DataRow(
                          cells: [
                            DataCell(
                              Container(
                                  width: 100,
                                  child: Text(
                                    data_.Label.toString(),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Kanit',
                                        fontWeight: FontWeight.normal),
                                  )),
                            ),
                            DataCell(
                              Container(
                                  width: 50,
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                      rf == "" ? "n/a" : data_.Rain.toString(),
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'Kanit',
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.right)),
                            ),
                            DataCell(
                              Container(
                                width: 50,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  wl == ""
                                      ? "n/a"
                                      : double.parse(data_.Water)
                                          .toStringAsFixed(2),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: size.width * 0.2,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  wl == "" ? "n/a" : data_.Flow,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            color: Colors.black.withOpacity(0.3),
            child: Text(
              "'n/a' หมายถึง ไม่มีการติดตั้งเครื่องมือวัด",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Kanit',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
