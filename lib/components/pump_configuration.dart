import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../models/mongo_db.dart';
import '../utils/mongodb_api.dart';

class PumpConfiguration extends StatefulWidget {
  const PumpConfiguration(
    this.data, {
    Key? key,
    required this.onEvent,
  }) : super(key: key);

  final MongoDbModel data;
  final VoidCallback onEvent;

  @override
  State<PumpConfiguration> createState() => _PumpConfigurationState();
}

class _PumpConfigurationState extends State<PumpConfiguration> {
  Duration pulseDuration = const Duration(minutes: 1, seconds: 00);
  Duration driveTime = const Duration(hours: 6, minutes: 00, seconds: 00);

  String durationToString(Duration duration) {
    String twoDigits(int number) => number.toString().padLeft(2, "0");

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  int durationToMilliseconds(Duration duration) {
    return duration.inMilliseconds;
  }

  Future<void> selectTime(
      Widget child, BuildContext inContext, time, Function updateHadler) async {
    showCupertinoModalPopup<void>(
      context: inContext,
      builder: (BuildContext inContext) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(inContext).viewInsets.bottom,
        ),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              top: false,
              child: child,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    updateHadler(time);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getInitialPulseDuration(int initialPulseDuration) {
    final initialDuration = Duration(milliseconds: initialPulseDuration);

    final minutes = initialDuration.inMinutes;
    final seconds = (initialDuration.inSeconds % 60).floor();

    final minutesDuration = Duration(minutes: minutes);
    final secondsDuration = Duration(seconds: seconds);

    final result = minutesDuration + secondsDuration;

    return result;
  }

  getInitialDriveTime(String initialDuration) {
    return Duration(
      hours: int.parse(initialDuration.split(":")[0]),
      minutes: int.parse(initialDuration.split(":")[1]),
      seconds: int.parse(initialDuration.split(":")[2]),
    );
  }

  Future<void> updateDriveTime(time) async {
    await MongoDatabase.updateTime(
        widget.data, time, durationToString(driveTime));
    widget.onEvent();
  }

  Future<void> updatePulseDuration(time) async {
    await MongoDatabase.updatePulseDuration(
        widget.data, durationToMilliseconds(pulseDuration));
    widget.onEvent();
  }

  Future<void> updateSate(int index, bool newState) async {
    await MongoDatabase.updateState(
        widget.data, widget.data.driveTimes![index]!.time!, newState);
    widget.onEvent();
  }

  Future<void> insertDriveTime(time) async {
    await MongoDatabase.insertTime(widget.data, durationToString(driveTime));
    widget.onEvent();
  }

  Future<void> removeDriveTime(time, state) async {
    await MongoDatabase.removeTime(widget.data, time, state);
    widget.onEvent();
  }

  Future<void> deletePump() async {
    await MongoDatabase.delete(widget.data);
    widget.onEvent();
  }

  showAlert(Function callback, [String? time, bool? state]) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                time != null && state != null
                    ? callback(time, state)
                    : callback();
                Navigator.pop(context, 'OK');
                widget.onEvent();
              },
              child: const Text(
                'PERMANENTLY DELETE',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10),
      elevation: 20,
      color: const Color.fromARGB(255, 29, 27, 28),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(10.0),
        trailing: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        title: Text(
          '${widget.data.pumperName}',
          style: const TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 30.0,
                    runSpacing: 5.0,
                    children: <Widget>[
                      const Text(
                        'Pumper Code: ',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${widget.data.pumperCode}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                  child: Text(
                    'Pulse Duration:',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "${(widget.data.pulseDuration! / 1000).ceil()} seconds",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => selectTime(
                            CupertinoTimerPicker(
                              initialTimerDuration: getInitialPulseDuration(
                                  widget.data.pulseDuration!),
                              mode: CupertinoTimerPickerMode.ms,
                              onTimerDurationChanged: (Duration newDuration) {
                                setState(() => pulseDuration = newDuration);
                                Vibration.vibrate(
                                  duration: 5,
                                  amplitude: 100,
                                );
                              },
                            ),
                            context,
                            widget.data.pulseDuration!,
                            updatePulseDuration),
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Drive Times:',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(5.0),
                  // Sempre usar quando tiver ListView dentro de outro!
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.data.driveTimes!.length,
                  itemBuilder: (context, index) {
                    return Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      // spacing: 20.0,
                      runSpacing: 2.0,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => selectTime(
                              CupertinoTimerPicker(
                                initialTimerDuration: getInitialDriveTime(
                                    widget.data.driveTimes![index]!.time!),
                                mode: CupertinoTimerPickerMode.hms,
                                onTimerDurationChanged: (Duration newDuration) {
                                  setState(() => driveTime = newDuration);
                                  Vibration.vibrate(
                                    duration: 5,
                                    amplitude: 100,
                                  );
                                },
                              ),
                              context,
                              widget.data.driveTimes![index]!.time!,
                              updateDriveTime),
                          child: Text(
                            widget.data.driveTimes![index]!.time!,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Switch(
                          activeColor: Colors.indigo,
                          value: widget.data.driveTimes![index]!.state!,
                          onChanged: (bool newState) =>
                              updateSate(index, newState),
                        ),
                        IconButton(
                          onPressed: () async {
                            showAlert(
                              removeDriveTime,
                              widget.data.driveTimes![index]!.time,
                              widget.data.driveTimes![index]!.state,
                            );
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () async {
                          showAlert(deletePump);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Delete",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () async {
                          selectTime(
                              CupertinoTimerPicker(
                                initialTimerDuration: driveTime,
                                mode: CupertinoTimerPickerMode.hms,
                                onTimerDurationChanged: (Duration newDuration) {
                                  setState(() => driveTime = newDuration);
                                  Vibration.vibrate(
                                    duration: 5,
                                    amplitude: 100,
                                  );
                                },
                              ),
                              context,
                              widget.data,
                              insertDriveTime);
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Add Time",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
