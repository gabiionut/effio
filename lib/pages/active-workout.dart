import 'package:effio/core/models/active-workout-exercise.model.dart';
import 'package:effio/core/models/current-workout.model.dart';
import 'package:effio/core/models/stopwatch.dart';
import 'package:effio/core/models/workout-input.model.dart';
import 'package:effio/core/models/workout.model.dart';
import 'package:effio/dataset.dart';
import 'package:effio/pages/widgets/active-workout-exercise.dart';
import 'package:effio/pages/widgets/big-floating-action-button.dart';
import 'package:effio/pages/widgets/bottom-workout-bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/models/active-workout.model.dart';

class ActiveWorkout extends StatefulWidget {
  static const route = '/active-workout';

  ActiveWorkout({Key? key}) : super(key: key);

  @override
  State<ActiveWorkout> createState() => _ActiveWorkoutState();
}

class _ActiveWorkoutState extends State<ActiveWorkout> {
  ActiveWorkoutModel? activeWorkout;
  WorkoutInput? workoutInput;
  List<Exercise> exercises = WORKOUTS;

  @override
  void didChangeDependencies() {
    workoutInput = ModalRoute.of(context)!.settings.arguments as WorkoutInput;
    final workoutExercises = exercises
        .where((exercise) => workoutInput!.exerciseIds!.contains(exercise.id))
        .map((e) => ActiveWorkoutExercise.fromExercise(e))
        .toList();
    activeWorkout = ActiveWorkoutModel(workoutInput!.name!, DateTime.now(),
        workoutInput!.name!, workoutExercises);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activeWorkout!.name),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: activeWorkout!.exercises.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == (activeWorkout!.exercises.length - 1)
                      ? 75
                      : 15.0),
              child: ActiveExerciseCard(
                exercise: activeWorkout!.exercises[index],
                workout: activeWorkout,
                exerciseStarted: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: Consumer<CurrentWorkoutModel>(
        builder: (context, value, child) => value.currentWorkout == null ||
                value.currentWorkout!.workoutId != activeWorkout!.workoutId
            ? BigFloatingActionButton(
                icon: Icons.fitness_center,
                text: 'Start workout',
                onPressed: () {
                  Provider.of<CurrentWorkoutModel>(context, listen: false)
                      .setCurrentWorkout(workout: activeWorkout!);
                  Provider.of<StopWatch>(context, listen: false).startTimer();
                  Navigator.pop(context, true);
                },
              )
            : Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
