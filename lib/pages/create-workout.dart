import 'package:effio/core/models/workout-input.model.dart';
import 'package:effio/core/models/workout.model.dart';
import 'package:effio/dataset.dart';
import 'package:effio/pages/widgets/big-floating-action-button.dart';
import 'package:effio/pages/widgets/bottom-workout-bar.dart';
import 'package:effio/pages/widgets/exercises-list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateWorkout extends StatefulWidget {
  static const route = '/create-session';
  const CreateWorkout({Key? key}) : super(key: key);
  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  var uuid = const Uuid();
  var workoutInput = WorkoutInput();
  final nameController = TextEditingController();
  final List<Exercise> workouts = WORKOUTS;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final workout = ModalRoute.of(context)!.settings.arguments as WorkoutInput?;
    if (workout != null) {
      workoutInput = workout;
      nameController.text = workout.name!;
      workouts.forEach((element) =>
          element.isAdded = workoutInput.exerciseIds!.contains(element.id));
    }
  }

  @override
  void dispose() {
    workouts.forEach((element) => element.isAdded = false);
    super.dispose();
  }

  Future<void> saveWorkout() async {
    final SharedPreferences prefs = await _prefs;
    final String? workoutsString = prefs.getString('workouts');
    if (workoutsString == null) {
      prefs.setString('workouts', WorkoutInput.encode([workoutInput]));
    } else {
      final List<WorkoutInput> workouts = WorkoutInput.decode(workoutsString);
      var existingWorkoutId =
          workouts.indexWhere((element) => element.id == workoutInput.id);
      if (existingWorkoutId != -1) {
        workouts[existingWorkoutId] = workoutInput;
      } else {
        workouts.add(workoutInput);
      }
      prefs.setString('workouts', WorkoutInput.encode(workouts));
    }
  }

  Future<void> save(BuildContext context) async {
    workoutInput.name = nameController.text;
    workoutInput.id ??= uuid.v4();
    workoutInput.exerciseIds =
        workouts.where((element) => element.isAdded).map((e) => e.id).toList();
    await saveWorkout();
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create workout',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: nameController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                label: Text(
                  'Enter a name for the workout',
                ),
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExercisesList(workouts: workouts),
            ),
          )
        ],
      ),
      floatingActionButton: BigFloatingActionButton(
        text: workoutInput.id != null ? 'Save' : 'Create',
        onPressed: () async {
          await save(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }
}
