import 'package:effio/core/models/workout.model.dart';

class ActiveWorkoutExercise {
  final bool isCompleted;
  final int id;
  final String name;
  final String description;
  final String image;
  final String video;
  final String howDescription;
  final String whyDescription;
  final List<String> tags;

  ActiveWorkoutExercise(this.isCompleted, this.id, this.name, this.description,
      this.image, this.video, this.howDescription, this.whyDescription, this.tags);

  factory ActiveWorkoutExercise.fromExercise(Exercise exercise) {
    return ActiveWorkoutExercise(
      false,
      exercise.id,
      exercise.name,
      exercise.description,
      exercise.image,
      exercise.video,
      exercise.howDescription,
      exercise.whyDescription,
      exercise.tags,
    );
  }
}
