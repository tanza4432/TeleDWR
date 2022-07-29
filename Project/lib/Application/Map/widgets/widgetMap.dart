import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";

class WidgetMap extends StatelessWidget {
  const WidgetMap({
    Key key,
    @required this.polygon,
    @required Set<Marker> markers,
  })  : _markers = markers,
        super(key: key);

  final List<LatLng> polygon;
  final Set<Marker> _markers;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(17.1408165, 103.4063071),
        // กรุงเทพ LatLng(13.782694, 100.5549202),
        zoom: 8,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        PolygonLayerOptions(
          polygonCulling: true,
          polygons: [
            Polygon(
              points: polygon,
              color: Colors.yellow[600].withOpacity(0.4),
              borderStrokeWidth: 2,
              borderColor: Colors.brown,
            ),
          ],
        ),
        MarkerLayerOptions(markers: _markers.toList()),
      ],
    );
  }
}
