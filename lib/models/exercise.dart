import 'dart:convert';

import 'package:http/http.dart' as http;

class Exercise {
  String? name = '';
  String? type = '';
  String? muscle = '';
  String? equipment = '';
  String? difficulty = '';
  String? instructions = '';
  String apiUrl = '';

  Exercise(
      [this.name,
      this.type,
      this.muscle,
      this.equipment,
      this.difficulty,
      this.instructions]) {
    apiUrl =
        'https://api.api-ninjas.com/v1/exercises?${muscle == null ? '' : 'muscle=$muscle'}${difficulty == null ? '' : '&difficulty=$difficulty'}${type == null ? '' : '&type=$type'}';
  }
  final String apiKey = 'OeiIeuDhUhbshorBSqO+zg==YBxzWtq3lyXCVoQq';

  Future<List<dynamic>> fetchExercises() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-Api-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<List<dynamic>> Searchbyname(String name) async{
    String url ='https://api.api-ninjas.com/v1/exercises?name=$name';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Api-Key': apiKey,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exercises');
    }
  } 
}
