import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class TabFour extends StatefulWidget {
  TabFour(this.stnId, this.basinId, this.CCTV, this.title);
  var stnId;
  var basinId;
  var CCTV;
  var basinName;
  String title;

  @override
  State<TabFour> createState() => _TabFourState();
}

class _TabFourState extends State<TabFour> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.basinName = widget.basinId == 1
        ? "maeklong"
        : widget.basinId == 2
            ? "salawin"
            : widget.basinId == 3
                ? "kokkhong"
                : widget.basinId == 4
                    ? "songkramhuailuang"
                    : widget.basinId == 5
                        ? "bangpakong"
                        : widget.basinId == 6
                            ? "bangsaphan"
                            : widget.basinId == 7
                                ? "nakhonsri"
                                : "maeklong";
    if (widget.basinId > 3) {
      check = true;
    }
    if (widget.CCTV == "") {
      return Column(
        children: [
          TabTitleBar(stnId: widget.stnId, title: widget.title),
          Container(
            height: size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "สถานีนี้ไม่มีข้อมูล CCTV",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          TabTitleBar(stnId: widget.stnId, title: widget.title),
          Container(
            width: double.infinity,
            height: size.height * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Text(
                    "ข้อมูลภาพ CCTV: " + widget.stnId,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var streamCCTV = await getCCTVStream(widget.stnId);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 500,
                              height: size.width * 9 / 16,
                              child: WebView(
                                javascriptMode: JavascriptMode.unrestricted,
                                initialUrl: streamCCTV,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "View CCTV",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Icon(
                          Icons.videocam,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  check
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HeroPhotoViewRouteWrapper(
                                        imageProvider: NetworkImage(
                                          'http://tele-' +
                                              widget.basinName +
                                              '.dwr.go.th/image/' +
                                              widget.stnId +
                                              '/CCTV_image/Overview_1.jpg',
                                        ),
                                        path: 'http://tele-' +
                                            widget.basinName +
                                            '.dwr.go.th/image/' +
                                            widget.stnId +
                                            '/CCTV_image/Overview_1.jpg',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Hero(
                                    tag: "1",
                                    child: Image.network(
                                      'http://tele-' +
                                          widget.basinName +
                                          '.dwr.go.th/image/' +
                                          widget.stnId +
                                          '/CCTV_image/Overview_1.jpg',
                                      loadingBuilder: (context, child, chunk) =>
                                          chunk != null
                                              ? Text("loading")
                                              : child,
                                    ),
                                  ),
                                ),
                              ),
                              // ZoomOverlay(
                              //   minScale: 0.5,
                              //   maxScale: 3.0,
                              //   twoTouchOnly: true,
                              //   child: ClipRRect(
                              //     child: FadeInImage.assetNetwork(
                              //       placeholder: 'assets/images/loading1.gif',
                              //       image: ('http://tele-' +
                              //           widget.basinName +
                              //           '.dwr.go.th/image/' +
                              //           widget.stnId +
                              //           '/CCTV_image/Overview_1.jpg'),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HeroPhotoViewRouteWrapper(
                                  imageProvider: NetworkImage(
                                    'http://tele-' +
                                        widget.basinName +
                                        '.dwr.go.th/image/' +
                                        widget.stnId +
                                        '/CCTV_image/Staff_1.jpg',
                                  ),
                                  path: 'http://tele-' +
                                      widget.basinName +
                                      '.dwr.go.th/image/' +
                                      widget.stnId +
                                      '/CCTV_image/Staff_1.jpg',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: Hero(
                              tag: "2",
                              child: Image.network(
                                'http://tele-' +
                                    widget.basinName +
                                    '.dwr.go.th/image/' +
                                    widget.stnId +
                                    '/CCTV_image/Staff_1.jpg',
                                loadingBuilder: (context, child, chunk) =>
                                    chunk != null ? Text("loading") : child,
                              ),
                            ),
                          ),
                        ),
                        // ZoomOverlay(
                        //   minScale: 0.5,
                        //   maxScale: 3.0,
                        //   child: ClipRRect(
                        //     child: FadeInImage.assetNetwork(
                        //       placeholder: 'assets/images/loading1.gif',
                        //       image: ('http://tele-' +
                        //           widget.basinName +
                        //           '.dwr.go.th/image/' +
                        //           widget.stnId +
                        //           '/CCTV_image/Staff_1.jpg'),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabTitleBar extends StatelessWidget {
  const TabTitleBar({
    Key key,
    @required this.stnId,
    @required this.title,
  }) : super(key: key);

  final String stnId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.path,
  });

  final ImageProvider imageProvider;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: PhotoView(
            imageProvider: imageProvider,
            backgroundDecoration: backgroundDecoration,
            minScale: minScale,
            maxScale: maxScale,
            heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var a = await ImageDownloader.downloadImage(path);
                    print(a);
                  },
                  child: Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
