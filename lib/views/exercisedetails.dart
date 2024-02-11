import 'package:flutter/material.dart';

class ExerciseDetails extends StatelessWidget {
  final Map<String, dynamic> exercise;

  const ExerciseDetails({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Exercise Details'),
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('NAME:\n${exercise['name']}'),
              tileColor: Colors.blue,
            ),
            Divider(color: Colors.transparent,),
            ListTile(
              title: Text('TYPE:\n${exercise['type']}'),
              tileColor: Colors.blue,
            ),
            Divider(color: Colors.transparent,),
            ListTile(
              title: Text('MUSCLE:\n${exercise['muscle']}'),
              tileColor: Colors.blue,
            ),
            Divider(color: Colors.transparent,),
            ListTile(
              title: Text('EQUIPMENT:\n${exercise['equipment']}'),
              tileColor: Colors.blue,
            ),
            Divider(color: Colors.transparent,),
            ListTile(
              title: Text('DIFFICULTY:\n${exercise['difficulty']}'),
              tileColor: Colors.blue,
            ),
            Divider(color: Colors.transparent,),
            ListTile(
              title: Text('INSTRUCTIONS:\n${exercise['instructions']}'),
              tileColor: Colors.blue,
            ),
          ],
        ));
  }
}
