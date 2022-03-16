import 'package:effio/core/models/workout-input.model.dart';
import 'package:effio/pages/widgets/bottom-workout-bar.dart';
import 'package:effio/pages/widgets/workout-bottom-sheet.dart';
import 'package:effio/pages/widgets/workout-cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/widgets/effio-app-bar.dart';
import 'create-workout.dart';

class WorkoutsList extends StatefulWidget {
  const WorkoutsList({Key? key}) : super(key: key);

  @override
  State<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {
  List<WorkoutInput> workouts = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    getWorkouts();
    super.initState();
  }

  Future<void> getWorkouts() async {
    final SharedPreferences prefs = await _prefs;
    final String? workoutsString = prefs.getString('workouts');
    if (workoutsString != null) {
      setState(() {
        workouts = WorkoutInput.decode(workoutsString);
      });
    }
    // final success = await prefs.remove('workouts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EffioAppBar(),
      body: workouts.isEmpty
          ? Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 200),
                child: Image.asset(
                  'assets/images/empty-workout.png',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == (workouts.length - 1) ? 75 : 15.0),
                    child: WorkoutCard(
                      workout: workouts[index],
                      index: index,
                      onUpdate: getWorkouts,
                      workoutStarted: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (context) {
                              return const WorkoutBottomSheet();
                            });
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateWorkout.route)
              .then((value) => getWorkouts());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: const BottomWorkoutBar(),
    );
  }
}
