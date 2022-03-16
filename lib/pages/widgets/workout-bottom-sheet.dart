import 'package:effio/core/models/current-workout.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/stopwatch.dart';

class WorkoutBottomSheet extends StatefulWidget {
  const WorkoutBottomSheet({Key? key}) : super(key: key);

  @override
  State<WorkoutBottomSheet> createState() => _WorkoutBottomSheetState();
}

class _WorkoutBottomSheetState extends State<WorkoutBottomSheet>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  bool isPlaying = true;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    isPlaying = Provider.of<StopWatch>(context, listen: false).isRunning;
    if (isPlaying) {
      _animationController!.forward();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(Provider.of<StopWatch>(context).duration.inHours);
    final minutes = twoDigits(
        Provider.of<StopWatch>(context).duration.inMinutes.remainder(60));
    final seconds = twoDigits(
        Provider.of<StopWatch>(context).duration.inSeconds.remainder(60));

    return Provider.of<CurrentWorkoutModel>(context).currentWorkout != null &&
            Provider.of<CurrentWorkoutModel>(context).currentExercise != null
        ? Container(
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.only(
              top: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                  .padding
                  .top,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(Provider.of<CurrentWorkoutModel>(context)
                    .currentWorkout!
                    .name),
                leading: IconButton(
                  icon: const Icon(Icons.expand_more),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Provider.of<CurrentWorkoutModel>(context)
                        .currentExercise!
                        .name,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Image.asset(
                          Provider.of<CurrentWorkoutModel>(context)
                              .currentExercise!
                              .video)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color(0xff384147),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SingleChildScrollView(
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'How?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text: Provider.of<CurrentWorkoutModel>(
                                            context)
                                        .currentExercise!
                                        .howDescription,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color(0xff384147),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SingleChildScrollView(
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Why?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                      text: Provider.of<CurrentWorkoutModel>(
                                              context)
                                          .currentExercise!
                                          .whyDescription),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        hours != '00'
                            ? '$hours:$minutes:$seconds'
                            : '$minutes:$seconds',
                        style: const TextStyle(
                          // color: Theme.of(context).colorScheme.secondary,
                          color: Colors.white,
                          fontSize: 60,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'Rammetto One',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: const Icon(Icons.stop),
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<CurrentWorkoutModel>(context,
                                    listen: false)
                                .stopWorkout();
                            Provider.of<StopWatch>(context, listen: false)
                                .stopTimer();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                            primary: const Color(0xffe64f1c),
                          ),
                        ),
                        ElevatedButton(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            size: 45,
                            color: Colors.black,
                            progress: _animationController!,
                          ),
                          onPressed: () {
                            setState(() {
                              isPlaying = !isPlaying;
                              if (!isPlaying) {
                                Provider.of<StopWatch>(context, listen: false)
                                    .pauseTimer();
                                _animationController!.reverse();
                              } else {
                                Provider.of<StopWatch>(context, listen: false)
                                    .resumeTimer();
                                _animationController!.forward();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 100),
                            shape: const CircleBorder(),
                            primary: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        ElevatedButton(
                          child: const Icon(
                            Icons.skip_next,
                          ),
                          onPressed: () {
                            Provider.of<CurrentWorkoutModel>(context,
                                    listen: false)
                                .nextExercise();
                            Provider.of<StopWatch>(context, listen: false)
                                .reset();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                            primary: const Color(0xff384147),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
        : const Scaffold();
  }
}
