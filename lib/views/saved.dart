import 'package:flutter/material.dart';
import 'package:mp5/models/exercise.dart';
import 'package:mp5/views/exercisedetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedPage extends StatefulWidget {
  final List<String> savedExercise;

  const SavedPage(this.savedExercise, {Key? key}) : super(key: key);

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Workout'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: widget.savedExercise.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              Exercise e = Exercise(widget.savedExercise[index], '', '', '');
              var sbname = await e.Searchbyname(widget.savedExercise[index]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetails(
                    exercise: {
                      'name': sbname[0]['name'],
                      'type': sbname[0]['type'],
                      'muscle': sbname[0]['muscle'],
                      'equipment': sbname[0]['equipment'],
                      'difficulty': sbname[0]['difficulty'],
                      'instructions': sbname[0]['instructions'],
                    },
                  ),
                ),
              );
            },
            onHover: (isHovered) {
            },
            hoverColor: Colors.grey.withOpacity(0.5), // Set the hover color
            child: ListTile(
              title: Text(widget.savedExercise[index]),
              tileColor: Colors.cyan,
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.savedExercise.remove(widget.savedExercise[index]);
                    _saveToSharedPreferences(widget.savedExercise);
                  });
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: botnavbar(),
    );
  }

  BottomNavigationBar botnavbar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _currentIndex == 0
              ? Navigator.pushNamedAndRemoveUntil(
                  context, '/', (route) => false)
              : _navigateToSavedPage();
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_add_sharp),
          label: 'Saved',
        ),
      ],
    );
  }

  void _navigateToSavedPage() async {}

  Future<void> _saveToSharedPreferences(List<String> savedExercise) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedExercise', savedExercise);
  }
}
