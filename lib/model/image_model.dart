// To parse this JSON data, do
//
//     final imageModel = imageModelFromMap(jsonString);

import 'dart:convert';

class ImageModel {
    ImageModel({
        required this.data
    });

    List<Datum> data;

    factory ImageModel.fromJson(String str) => ImageModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x)))
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap()))
    };
}

class Datum {
    Datum({
        required this.title,
        required this.images,
    });

    String title;
    Images images;

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        title: json["title"],
        images: Images.fromMap(json["images"]),
    );

    Map<String, dynamic> toMap() => {
        "title": title,
        "images": images.toMap(),
    };
}


class Images {
    Images({
        required this.original
    });

    FixedHeight original;

    factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Images.fromMap(Map<String, dynamic> json) => Images(
        original: FixedHeight.fromMap(json["fixed_width"])
    );

    Map<String, dynamic> toMap() => {
        "original": original.toMap(),
    };
}

class FixedHeight {
    FixedHeight({
        required this.url
    });

    String url;

    factory FixedHeight.fromJson(String str) => FixedHeight.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FixedHeight.fromMap(Map<String, dynamic> json) => FixedHeight(
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "url": url,
    };
}