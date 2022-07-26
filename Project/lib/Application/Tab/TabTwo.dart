import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/dataOffline_Model.dart';
import 'package:dwr0001/Models/data_Model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class TabTwo extends StatelessWidget {
  TabTwo(this.stnId, this.title);
  var stnId;
  String title;
  List<DataModelGet> resultOffline = [];
  bool check = false;

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
              data = snapshot.data;
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
          DataTable(
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
              rows: data
                  .map((data_) => DataRow(cells: [
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
                              child: Text(data_.Rain_15_M.toString(),
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
                              child: Text(data_.Water_D.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontWeight: FontWeight.normal))),
                        ),
                        DataCell(
                          Container(
                              width: 50,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                data_.Water_F.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                      ]))
                  .toList()),
        ],
      ),
    );
  }
}
