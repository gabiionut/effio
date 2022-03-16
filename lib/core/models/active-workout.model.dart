import 'package:effio/core/models/active-workout-exercise.model.dart';

class ActiveWorkoutModel {
  final String workoutId;
  final DateTime date;
  final String name;
  List<ActiveWorkoutExercise> exercises;

  ActiveWorkoutModel(
    this.workoutId,
    this.date,
    this.name,
    this.exercises,
  );
}
