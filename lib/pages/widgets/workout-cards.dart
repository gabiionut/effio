import 'package:effio/core/models/workout-input.model.dart';
import 'package:effio/pages/active-workout.dart';
import 'package:effio/pages/create-workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutCard extends StatefulWidget {
  WorkoutInput workout;
  int index;
  VoidCallback onUpdate = () {};
  VoidCallback workoutStarted = () {};

  WorkoutCard(
      {Key? key,
      required this.workout,
      required this.index,
      required this.onUpdate,
      required this.workoutStarted})
      : super(key: key);

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  late SwipeActionController controller;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    controller = SwipeActionController();
  }

  Future<void> saveWorkout() async {
    final SharedPreferences prefs = await _prefs;
    final String? workoutsString = prefs.getString('workouts');

    final List<WorkoutInput> workouts = WorkoutInput.decode(workoutsString!);
    workouts.removeAt(widget.index);
    prefs.setString('workouts', WorkoutInput.encode(workouts));
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
        // backgroundColor: const Color(0xff131A1C),
        controller: controller,
        key: ValueKey(widget.workout),
        trailingActions: [
          SwipeAction(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              nestedAction: SwipeNestedAction(title: "Confirm"),
              onTap: (handler) async {
                await handler(true);
                saveWorkout();
              }),
          SwipeAction(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.secondary,
              onTap: (handler) async {
                var value = await Navigator.pushNamed(
                    context, CreateWorkout.route,
                    arguments: widget.workout);
                if (value != null) {
                  widget.onUpdate();
                }
                controller.closeAllOpenCell();
              }),
        ],
        child: InkWell(
          onTap: () async {
            dynamic res = await Navigator.of(context).pushNamed(
                ActiveWorkout.route,
                arguments: widget.workout);
            if (res == true) {
              widget.workoutStarted();
            }
          },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          splashColor: Theme.of(context).colorScheme.secondary,
          child: Card(
            color: const Color(0xff131A1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
            child: SizedBox(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      widget.workout.name!,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Image.asset(
                      'assets/images/workout${(widget.index % 12).floor()}.png',
                      height: 166,
                      width: 140,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
