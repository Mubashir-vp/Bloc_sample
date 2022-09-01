// To parse this JSON data, do
//
//     final memeModel = memeModelFromJson(jsonString);

import 'dart:convert';

MemeModel memeModelFromJson(String str) => MemeModel.fromJson(json.decode(str));

String memeModelToJson(MemeModel data) => json.encode(data.toJson());

class MemeModel {
    MemeModel({
        this.success,
        this.data,
    });

    bool? success;
    Data? data;

    factory MemeModel.fromJson(Map<String, dynamic> json) => MemeModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.memes,
    });

    List<Meme>? memes;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        memes: List<Meme>.from(json["memes"].map((x) => Meme.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "memes": List<dynamic>.from(memes!.map((x) => x.toJson())),
    };
}

class Meme {
    Meme({
        this.id,
        this.name,
        this.url,
        this.width,
        this.height,
        this.boxCount,
    });

    String? id;
    String ?name;
    String ?url;
    int ?width;
    int ?height;
    int ?boxCount;

    factory Meme.fromJson(Map<String, dynamic> json) => Meme(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
        boxCount: json["box_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "width": width,
        "height": height,
        "box_count": boxCount,
    };
}
