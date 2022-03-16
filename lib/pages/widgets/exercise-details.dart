import 'package:effio/core/models/active-workout.model.dart';
import 'package:effio/core/models/current-workout.model.dart';
import 'package:effio/pages/widgets/bottom-workout-bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/active-workout-exercise.model.dart';
import '../../core/models/stopwatch.dart';
import '../../core/models/workout.model.dart';

class ExerciseDetails extends StatefulWidget {
  Exercise exercise;
  bool? isActive;
  ActiveWorkoutModel? workout;
  VoidCallback? exerciseStarted;

  ExerciseDetails(
      {Key? key, required this.exercise, this.isActive, this.workout, this.exerciseStarted})
      : super(key: key);

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.exercise.name,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 320,
            child: Image.asset(
              widget.exercise.video,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xff384147),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'How?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          const TextSpan(text: ' '),
                          TextSpan(text: widget.exercise.howDescription),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xff384147),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Why?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          const TextSpan(text: ' '),
                          TextSpan(text: widget.exercise.whyDescription),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<CurrentWorkoutModel>(
        builder: (context, value, child) => value.currentWorkout == null ||
                value.currentWorkout!.workoutId != widget.workout!.workoutId ||
                value.currentExercise!.id != widget.exercise.id
            ? SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                height: 55,
                child: widget.isActive == null
                    ? FloatingActionButton.extended(
                        onPressed: () {
                          widget.exercise.isAdded = !widget.exercise.isAdded;
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                            widget.exercise.isAdded ? Icons.remove : Icons.add),
                        label: Text(
                          widget.exercise.isAdded
                              ? 'Remove from workout'
                              : 'Add to workout',
                          style: const TextStyle(fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      )
                    : FloatingActionButton.extended(
                        onPressed: () {
                          Provider.of<CurrentWorkoutModel>(context,
                                  listen: false)
                              .setCurrentWorkout(
                            workout: widget.workout!,
                            exercise: ActiveWorkoutExercise(
                              false,
                              widget.exercise.id,
                              widget.exercise.name,
                              widget.exercise.description,
                              widget.exercise.image,
                              widget.exercise.video,
                              widget.exercise.howDescription,
                              widget.exercise.whyDescription,
                              widget.exercise.tags,
                            ),
                          );
                          Provider.of<StopWatch>(context, listen: false)
                              .startTimer();
                          widget.exerciseStarted!();
                        },
                        icon: const Icon(Icons.fitness_center),
                        label: const Text(
                          'Start exercise',
                          style: TextStyle(fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
              )
            : Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
