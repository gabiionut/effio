import 'dart:convert';

class WorkoutInput {
  String? id;
  String? name = '';
  List<int>? exerciseIds = [];
  WorkoutInput({this.id, this.name, this.exerciseIds});

  factory WorkoutInput.fromJson(Map<String, dynamic> jsonData) {
    return WorkoutInput(
      id: jsonData['id'],
      name: jsonData['name'],
      exerciseIds: (jsonData['exerciseIds']).cast<int>().toList(),
    );
  }

  static Map<String, dynamic> toMap(WorkoutInput workout) => {
        'id': workout.id,
        'name': workout.name,
        'exerciseIds': workout.exerciseIds,
      };

  static String encode(List<WorkoutInput> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => WorkoutInput.toMap(music))
            .toList(),
      );

  static List<WorkoutInput> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<WorkoutInput>((item) => WorkoutInput.fromJson(item))
          .toList();
}
