import 'package:flutter/material.dart';

import 'active-workout-exercise.model.dart';
import 'active-workout.model.dart';

class CurrentWorkoutModel extends ChangeNotifier {
  ActiveWorkoutModel? currentWorkout;
  ActiveWorkoutExercise? currentExercise;

  void setCurrentWorkout(
      {required ActiveWorkoutModel workout, ActiveWorkoutExercise? exercise}) {
    currentWorkout = workout;
    if (exercise != null) {
      currentExercise = exercise;
    } else {
      currentExercise = workout.exercises.first;
    }
    notifyListeners();
  }

  void setCurrentExercise(ActiveWorkoutExercise exercise) {
    currentExercise = exercise;
    notifyListeners();
  }

  void nextExercise() {
    var currentIndex = currentWorkout!.exercises.indexOf(currentExercise!);
    if (currentIndex < currentWorkout!.exercises.length - 1) {
      currentExercise = currentWorkout!.exercises[currentIndex + 1];
    } else {
      currentExercise = currentWorkout!.exercises.first;
    }
    notifyListeners();
  }

  void stopWorkout() {
    currentWorkout = null;
    currentExercise = null;
    notifyListeners();
  }
}
