import 'dart:async';

import 'package:animations/animations.dart';
import 'package:effio/core/models/workout.model.dart';
import 'package:effio/pages/widgets/exercise-details.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  Exercise exercise;
  ExerciseCard({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  Color getColor(Set<MaterialState> states) {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 300),
        openBuilder: (context, _) => ExerciseDetails(exercise: widget.exercise),
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        closedColor: const Color(0xff131A1C),
        openColor: Theme.of(context).scaffoldBackgroundColor,
        closedBuilder: (context, VoidCallback openContainer) => InkWell(
              splashColor: Theme.of(context).colorScheme.secondary,
              onLongPress: () => setState(
                  () => widget.exercise.isAdded = !widget.exercise.isAdded),
              onTap: openContainer,
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
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: widget.exercise.isAdded,
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.exercise.isAdded = value!;
                                });
                              },
                            ),
                            Text(
                              widget.exercise.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                widget.exercise.image,
                                height: 140,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 25, 10, 25),
                                child: Column(
                                  children: [
                                    Text(
                                      widget.exercise.description,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    const SizedBox(height: 15),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Wrap(
                                        spacing: 8,
                                        children: [
                                          ...widget.exercise.tags
                                              .map((tag) => Chip(
                                                    label: Text(
                                                      tag,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        const Color(
                                                            0xff384147),
                                                  ))
                                              .toList()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
