import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel? mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel? data) => json.encode(data!.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    required this.pumperCode,
    required this.pumperName,
    required this.pulseDuration,
    required this.driveTimes,
  });

  ObjectId? id;
  String? pumperCode;
  String? pumperName;
  int? pulseDuration;
  List<DriveTime?>? driveTimes;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        pumperCode: json["pumperCode"],
        pumperName: json["pumperName"],
        pulseDuration: json["pulseDuration"],
        driveTimes: json["driveTimes"] == null
            ? []
            : List<DriveTime?>.from(
                json["driveTimes"]!.map((x) => DriveTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "pumperCode": pumperCode,
        "pumperName": pumperName,
        "pulseDuration": pulseDuration,
        "driveTimes": driveTimes == null
            ? []
            : List<dynamic>.from(driveTimes!.map((x) => x!.toJson())),
      };
}

class DriveTime {
  DriveTime({
    required this.time,
    required this.state,
  });

  String? time;
  bool? state;

  factory DriveTime.fromJson(Map<String, dynamic> json) => DriveTime(
        time: json["time"] as String,
        state: json["state"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "state": state,
      };
}
