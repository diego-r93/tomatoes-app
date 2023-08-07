import 'package:mongo_dart/mongo_dart.dart';

import '../models/mongo_db.dart';
import './constants.dart';

class MongoDatabase {
  static dynamic db, collection;

  static Future<void> connect() async {
    db = await Db.create(mongoConnUrl);
    await db.open();
    collection = db.collection(userCollection);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    List<Map<String, dynamic>> arrData = [];

    while (!db.isConnected) {
      await db.close();
      await db.open();
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Espera meio segundo antes de verificar novamente
    }

    arrData = await collection.find().toList();

    return arrData;
  }

  static Future<String> insert({
    required String? pumperCode,
    required String? pumperName,
    required int pulseDuration,
  }) async {
    try {
      var result = await collection.insertOne(<String, dynamic>{
        "_id": ObjectId(),
        "pumperCode": pumperCode,
        "pumperName": pumperName,
        "pulseDuration": pulseDuration,
        "driveTimes": []
      });

      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong while insering data.";
      }
    } catch (error) {
      return error.toString();
    }
  }

  static Future<int> insertTime(MongoDbModel data, String newTime) async {
    var result = await collection.updateOne(
      where.eq("_id", data.id),
      ModifierBuilder().push(r'driveTimes', {"time": newTime, "state": false}),
      writeConcern: const WriteConcern(
          // Procurar saber do que se trata!!
          w: 'majority',
          wtimeout: 5000),
    );
    return result.nModified;
  }

  static Future<int> updatePulseDuration(
      MongoDbModel data, int newPulseDuration) async {
    var result = await collection.updateOne(
      where.eq("_id", data.id),
      ModifierBuilder().set(r'pulseDuration', newPulseDuration),
      writeConcern: const WriteConcern(
          // Procurar saber do que se trata!!
          w: 'majority',
          wtimeout: 5000),
    );
    return result.nModified;
  }

  static Future<int> updateState(
      MongoDbModel data, String selectedTime, bool selectedState) async {
    var result = await collection.updateOne(
      where.eq("_id", data.id),
      ModifierBuilder().set(r'driveTimes.$[element].state', selectedState),
      arrayFilters: [
        {
          'element.time': {r'$eq': selectedTime}
        }
      ],
      writeConcern: const WriteConcern(
          // Procurar saber do que se trata!!
          w: 'majority',
          wtimeout: 5000),
    );
    return result.nModified;
  }

  static Future<int> updateTime(
      MongoDbModel data, String selectedTime, String newTime) async {
    var result = await collection.updateOne(
      where.eq("_id", data.id),
      ModifierBuilder().set(r'driveTimes.$[element].time', newTime),
      arrayFilters: [
        {
          'element.time': {r'$eq': selectedTime}
        }
      ],
      writeConcern: const WriteConcern(
          // Procurar saber do que se trata!!
          w: 'majority',
          wtimeout: 5000),
    );
    return result.nModified;
  }

  static Future<int> removeTime(
      MongoDbModel data, String selectedTime, bool selectedState) async {
    var result = await collection.updateOne(
      where.eq("_id", data.id),
      {
        r'$pull': {
          "driveTimes": {"time": selectedTime, "state": selectedState}
        }
      },
      writeConcern: const WriteConcern(
          // Procurar saber do que se trata!!
          w: 'majority',
          wtimeout: 5000),
    );
    return result.nModified;
  }

  static Future<void> delete(MongoDbModel user) async {
    await collection.remove(where.id(user.id!));
  }
}
