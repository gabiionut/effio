import 'dart:async';

import 'package:effio/core/models/current-workout.model.dart';
import 'package:effio/core/models/stopwatch.dart';
import 'package:effio/pages/widgets/workout-bottom-sheet.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class BottomWorkoutBar extends StatefulWidget {
  const BottomWorkoutBar({Key? key}) : super(key: key);

  @override
  State<BottomWorkoutBar> createState() => _BottomWorkoutBarState();
}

class _BottomWorkoutBarState extends State<BottomWorkoutBar> {
  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(Provider.of<StopWatch>(context).duration.inHours);
    final minutes = twoDigits(
        Provider.of<StopWatch>(context).duration.inMinutes.remainder(60));
    final seconds = twoDigits(
        Provider.of<StopWatch>(context).duration.inSeconds.remainder(60));

    return Consumer<CurrentWorkoutModel>(
        builder: ((context, value, child) => value.currentExercise != null
            ? GestureDetector(
                onTap: (() {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return const WorkoutBottomSheet();
                      });
                }),
                child: BottomAppBar(
                  color: Theme.of(context).colorScheme.primary,
                  child: SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 25, 0),
                                child: Text(
                                  hours != '00'
                                      ? '$hours:$minutes:$seconds'
                                      : '$minutes:$seconds',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 20,
                                    fontFamily: 'Rammetto One',
                                  ),
                                ),
                              ),
                              Consumer<CurrentWorkoutModel>(
                                builder: ((context, value, child) => value
                                                .currentExercise !=
                                            null &&
                                        value.currentWorkout != null
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Marquee(
                                          text:
                                              "${value.currentWorkout!.name} - ${value.currentExercise!.name}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                          scrollAxis: Axis.horizontal,
                                          blankSpace: 20.0,
                                          velocity: 100.0,
                                          pauseAfterRound: Duration(seconds: 1),
                                          startPadding: 10.0,
                                          accelerationDuration:
                                              Duration(seconds: 1),
                                          accelerationCurve: Curves.linear,
                                          decelerationDuration:
                                              Duration(milliseconds: 500),
                                          decelerationCurve: Curves.easeOut,
                                        ),
                                      )
                                    : const Text("",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14))),
                              )
                            ],
                          ),
                          Icon(
                            Icons.expand_less,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox()));
  }
}
