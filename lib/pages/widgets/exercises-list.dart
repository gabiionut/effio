import 'package:effio/core/models/workout.model.dart';
import 'package:effio/dataset.dart';
import 'package:effio/pages/widgets/exercise-card.dart';
import 'package:flutter/material.dart';

class ExercisesList extends StatefulWidget {
  List<Exercise> workouts = [];
  ExercisesList({Key? key, required this.workouts}) : super(key: key);

  @override
  State<ExercisesList> createState() => _ExercisesListState();
}

class _ExercisesListState extends State<ExercisesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.workouts.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: index == (widget.workouts.length - 1) ? 75 : 15.0),
          child: ExerciseCard(
            exercise: widget.workouts[index],
          ),
        );
      },
    );
  }
}
