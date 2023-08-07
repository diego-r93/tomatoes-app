import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../components/pump_configuration.dart';
import '../models/mongo_db.dart';
import '../utils/mongodb_api.dart';

class MyTimers extends StatefulWidget {
  const MyTimers({Key? key}) : super(key: key);

  @override
  State<MyTimers> createState() => _MyTimersState();
}

class _MyTimersState extends State<MyTimers> {
  late String? newPumperName;
  late String? newPumperCode;
  late int newPulseDuration = 60000;

  final _formKey = GlobalKey<FormState>();

  void _updateParentState() {
    setState(() {});
  }

  void _close() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Scaffold(
                                body: SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CupertinoTimerPicker(
                                            initialTimerDuration: Duration(
                                                milliseconds: newPulseDuration),
                                            mode: CupertinoTimerPickerMode.ms,
                                            onTimerDurationChanged:
                                                (Duration newDuration) {
                                              newPulseDuration =
                                                  newDuration.inMilliseconds;
                                              Vibration.vibrate(
                                                duration: 5,
                                                amplitude: 100,
                                              );
                                            },
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.name,
                                            decoration: const InputDecoration(
                                              labelText: "Pumper Name",
                                            ),
                                            validator: (pumperName) {
                                              if (pumperName == null ||
                                                  pumperName.isEmpty) {
                                                return "Enter Pumper Name";
                                              }
                                              return null;
                                            },
                                            onSaved: (String? pumperName) {
                                              newPumperName = pumperName;
                                            },
                                          ),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: const InputDecoration(
                                              labelText: "Pumper Code",
                                            ),
                                            validator: (pumperCode) {
                                              if (pumperCode == null ||
                                                  pumperCode.isEmpty) {
                                                return "Enter Pumper Name";
                                              }
                                              return null;
                                            },
                                            onSaved: (String? pumperCode) {
                                              newPumperCode = pumperCode;
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 25.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                OutlinedButton.icon(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  label: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                OutlinedButton.icon(
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                      await MongoDatabase
                                                          .insert(
                                                        pumperCode:
                                                            newPumperCode,
                                                        pumperName:
                                                            newPumperName,
                                                        pulseDuration:
                                                            newPulseDuration,
                                                      );
                                                      _close();
                                                      setState(() {});
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                  label: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      MongoDbModel dataFromDB =
                          MongoDbModel.fromJson(snapshot.data[index]);
                      return PumpConfiguration(
                        dataFromDB,
                        onEvent: _updateParentState,
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Awaiting result...',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
