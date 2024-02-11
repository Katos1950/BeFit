
import 'package:flutter/material.dart';
import 'package:mp5/models/exercise.dart';
import 'package:mp5/views/exercisedetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeFit extends StatefulWidget {
  String? type = '';
  String? muscle = '';
  String? difficulty = '';
  List<String>? savedExercise = [];
  BeFit(this.type, this.muscle, this.difficulty, this.savedExercise,
      {super.key});

  @override
  State<BeFit> createState() => _BeFit();
}

class _BeFit extends State<BeFit> {
  @override
  void initState() {
    super.initState();
    _loadFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    Exercise e = Exercise('name', widget.type, widget.muscle, 'equipment',
        widget.difficulty, 'instructions');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Be Fit"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: e.fetchExercises(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Handle the retrieved exercise data here
              List<dynamic>? exercises = snapshot.data;
              return ListView.builder(
                itemCount: exercises?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseDetails(exercise: exercises[index]),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(exercises![index]['name']),
                      tileColor: Colors.green,
                      trailing: IconButton(
                        icon: Icon(
                          widget.savedExercise
                                      ?.contains(exercises[index]['name']) ??
                                  false
                              ? Icons.bookmark_add_sharp
                              : Icons
                                  .bookmark_border, // You can customize the bookmark icon
                          color: Colors.black, // You can customize the bookmark icon color
                        ),
                        onPressed: () {
                          setState(
                            () {
                              widget.savedExercise!
                                      .contains(exercises[index]['name'])
                                  ? widget.savedExercise
                                      ?.remove(exercises[index]['name'])
                                  : widget.savedExercise
                                      ?.add(exercises[index]['name']);
                                      _saveToSharedPreferences(widget.savedExercise!);
                            },
                          );
                          // Handle bookmark button tap here
                          // You can add the logic to toggle the bookmark state for the current item
                        },
                      ),
                    ),
                    hoverColor: Colors.grey.withOpacity(0.5),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _saveToSharedPreferences(List<String> savedExercise) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedExercise', savedExercise);
  }

   Future<void> _loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedExercise = prefs.getStringList('savedExercise');
    if (savedExercise != null) {
      setState(() {
        widget.savedExercise = savedExercise;
      });
    }
  }

}

