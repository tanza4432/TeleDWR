import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfViewer extends StatefulWidget {
  var basinID;
  final List<StationModel> data;

  PdfViewer({Key key, this.basinID, this.data}) : super(key: key);
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    if (widget.basinID == 1) {
      document = await PDFDocument.fromAsset('assets/pdf/mk/mk.pdf');
    } else if (widget.basinID == 2) {
      document = await PDFDocument.fromAsset('assets/pdf/sl/sl.pdf');
    } else {
      document = await PDFDocument.fromAsset('assets/pdf/kk/kk.pdf');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[800],
          title: const Text('PDF TeleDWR'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPage(data: widget.data)))
            },
          ),
        ),
        body: Center(
            child: Container(
          child: PDFViewer(document: document),
        )),
      ),
    );
  }
}
