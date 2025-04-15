import 'package:flutter/material.dart';

void main() => runApp(HabitBuddyApp());

class HabitBuddyApp extends StatelessWidget {
  const HabitBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFF1F4F8),
        fontFamily: 'Arial',
      ),
      home: HabitHomePage(),
    );
  }
}

class HabitHomePage extends StatefulWidget {
  const HabitHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabitHomePageState createState() => _HabitHomePageState();
}

class _HabitHomePageState extends State<HabitHomePage> {
  List<Map<String, dynamic>> habits = [
    {"name": "🌞 Morning Workout", "isDone": false},
    {"name": "📖 Read 10 pages", "isDone": false},
    {"name": "🙏 Pray on time", "isDone": false},
  ];

  TextEditingController habitController = TextEditingController();

  void addHabit(String habitName) {
    setState(() {
      habits.add({"name": habitName, "isDone": false});
    });
    habitController.clear();
    Navigator.pop(context);
  }

  void showAddHabitDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text("Add New Habit"),
            content: TextField(
              controller: habitController,
              decoration: InputDecoration(
                hintText: "e.g., 🧘 Meditate",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (habitController.text.trim().isNotEmpty) {
                    addHabit(habitController.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  Widget buildHabitCard(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: Checkbox(
          value: habits[index]["isDone"],
          onChanged: (value) {
            setState(() {
              habits[index]["isDone"] = value!;
            });
          },
          activeColor: Colors.teal,
        ),
        title: Text(
          habits[index]["name"],
          style: TextStyle(
            fontSize: 18,
            decoration:
                habits[index]["isDone"] ? TextDecoration.lineThrough : null,
            color: habits[index]["isDone"] ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text("Habit Buddy"),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) => buildHabitCard(index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddHabitDialog,
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}
