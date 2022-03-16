import 'package:effio/core/models/current-workout.model.dart';
import 'package:effio/core/models/stopwatch.dart';
import 'package:effio/core/widgets/effio-app-bar.dart';
import 'package:effio/pages/active-workout.dart';
import 'package:effio/pages/create-workout.dart';
import 'package:effio/core/styles/theme.dart';
import 'package:effio/pages/workouts-list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CurrentWorkoutModel>(
        create: (_) => CurrentWorkoutModel(),
      ),
      ChangeNotifierProvider<StopWatch>(
        create: (_) => StopWatch(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Effio',
      debugShowCheckedModeBanner: false,
      theme: EffioTheme.darkTheme,
      home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        CreateWorkout.route: (context) => const CreateWorkout(),
        ActiveWorkout.route: (context) => ActiveWorkout(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const WorkoutsList();
  }
}
