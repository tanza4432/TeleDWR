import 'dart:convert';

MapModel mapModelFromJson(String str) => MapModel.fromJson(json.decode(str));

String mapModelToJson(MapModel data) => json.encode(data.toJson());

class MapModel {
  MapModel({
    this.type,
    this.features,
  });

  String type;
  List<Feature> features;

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    this.type,
    this.properties,
    this.geometry,
  });

  String type;
  Properties properties;
  Geometry geometry;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String type;
  List<List<List<List<double>>>> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<List<List<List<double>>>>.from(json["coordinates"]
            .map((x) => List<List<List<double>>>.from(x.map((x) =>
                List<List<double>>.from(x.map(
                    (x) => List<double>.from(x.map((x) => x.toDouble())))))))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) =>
            List<dynamic>.from(x.map((x) => List<dynamic>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))))),
      };
}

class Properties {
  Properties({
    this.style,
    this.url,
    this.name,
    this.nameE,
    this.description,
    this.tessellate,
    this.extrude,
    this.visibility,
    this.snippet,
  });

  Style style;
  String url;
  String name;
  String nameE;
  String description;
  int tessellate;
  int extrude;
  int visibility;
  String snippet;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        style: Style.fromJson(json["style"]),
        url: json["url"],
        name: json["Name"],
        nameE: json["Name_E"],
        description: json["description"],
        tessellate: json["tessellate"],
        extrude: json["extrude"],
        visibility: json["visibility"],
        snippet: json["snippet"],
      );

  Map<String, dynamic> toJson() => {
        "style": style.toJson(),
        "url": url,
        "Name": name,
        "Name_E": nameE,
        "description": description,
        "tessellate": tessellate,
        "extrude": extrude,
        "visibility": visibility,
        "snippet": snippet,
      };
}

class Style {
  Style({
    this.weight,
    this.color,
    this.opacity,
    this.fillColor,
    this.fillOpacity,
  });

  int weight;
  String color;
  double opacity;
  String fillColor;
  double fillOpacity;

  factory Style.fromJson(Map<String, dynamic> json) => Style(
        weight: json["weight"],
        color: json["color"],
        opacity: json["opacity"].toDouble(),
        fillColor: json["fillColor"],
        fillOpacity: json["fillOpacity"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "color": color,
        "opacity": opacity,
        "fillColor": fillColor,
        "fillOpacity": fillOpacity,
      };
}
