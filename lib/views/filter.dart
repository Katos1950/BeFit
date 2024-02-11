import 'package:flutter/material.dart';
import 'package:mp5/befit.dart';
import 'package:mp5/views/saved.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> savedExercise = [];
  // Selected options for each category
  String? selectedType;
  String? selectedMuscle;
  String? selectedDifficulty;
  int _currentIndex = 0;

  // Check if at least one category is selected
  bool isAtLeastOneCategorySelected() {
    return selectedType != null ||
        selectedMuscle != null ||
        selectedDifficulty != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to BeFit'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Type dropdown
            DropdownButtonFormField<String>(
              hint: const Text('Select Type'),
              value: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
              items: [
                'cardio',
                'olympic_weightlifting',
                'plyometrics',
                'powerlifting',
                'strength',
                'stretching',
                'strongman'
              ]
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Muscle dropdown
            DropdownButtonFormField<String>(
              hint: const Text('Select Muscle'),
              value: selectedMuscle,
              onChanged: (value) {
                setState(() {
                  selectedMuscle = value;
                });
              },
              items: [
                'abdominals',
                'abductors',
                'adductors',
                'biceps',
                'calves',
                'chest',
                'forearms',
                'glutes',
                'hamstrings',
                'lats',
                'lower_back',
                'middle_back',
                'neck',
                'quadriceps',
                'traps',
                'triceps'
              ]
                  .map((muscle) => DropdownMenuItem(
                        value: muscle,
                        child: Text(muscle),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Difficulty dropdown
            DropdownButtonFormField<String>(
              hint: const Text('Select Difficulty'),
              value: selectedDifficulty,
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value;
                });
              },
              items: ['beginner', 'intermediate', 'expert']
                  .map((difficulty) => DropdownMenuItem(
                        value: difficulty,
                        child: Text(difficulty),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Submit button
            ElevatedButton(
              onPressed:
                  isAtLeastOneCategorySelected() ? () => _onSubmit() : null,
              child: const Text('Submit'),
            ),
            Text("*Select at least one field")
          ],
        ),
      ),
      bottomNavigationBar: botnavbar(),
    );
  }

  // Handle submit button click
  void _onSubmit() {
    // Implement the logic to handle the selected options
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BeFit(
            selectedType, selectedMuscle, selectedDifficulty, savedExercise),
      ),
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

  void _navigateToSavedPage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> savedExercise = prefs.getStringList('savedExercise') ?? [];
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SavedPage(savedExercise)),
  );
}
}
