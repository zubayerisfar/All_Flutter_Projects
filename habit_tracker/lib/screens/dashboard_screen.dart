import 'package:flutter/material.dart';
import 'add_habit_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> habitTiles = [
      HabitTile(
        habitName: "Drinking Water",
        progress: "Progress: 33%",
        streak: "Streak: 2 days",
        icon: Icons.local_drink,
        tileColor: const Color.fromARGB(255, 218, 215, 215),
      ),
      HabitTile(
        habitName: "Exercise",
        progress: "Progress: 50%",
        streak: "Streak: 5 days",
        icon: Icons.fitness_center,
        tileColor: const Color.fromARGB(255, 100, 200, 150),
      ),
      HabitTile(
        habitName: "Reading",
        progress: "Progress: 75%",
        streak: "Streak: 10 days",
        icon: Icons.book,
        tileColor: const Color.fromARGB(255, 150, 150, 200),
      ),
      HabitTile(
        habitName: "Reading",
        progress: "Progress: 75%",
        streak: "Streak: 10 days",
        icon: Icons.wallet,
        tileColor: const Color.fromARGB(255, 193, 200, 100),
      ),
      HabitTile(
        habitName: "Reading",
        progress: "Progress: 75%",
        streak: "Streak: 10 days",
        icon: Icons.phone,
        tileColor: const Color.fromARGB(255, 165, 105, 123),
      ),
    ];

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
        ),
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 2,
          backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: const Color.fromARGB(179, 0, 0, 0)),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Habit Tracker")),
        body: SafeArea(
          bottom: false,
          child: isLandscape
              ? LandscapeLayout(habitTiles)
              : PotraitLayout(habitTiles),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddHabitScreen()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class PotraitLayout extends StatelessWidget {
  final List<Widget> habitTiles;

  const PotraitLayout(this.habitTiles, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(habitTiles[index]),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: habitTiles[index],
          ),
        );
      },
      itemCount: habitTiles.length,
    );
  }
}

class LandscapeLayout extends StatelessWidget {
  final List<Widget> habitTiles;

  const LandscapeLayout(this.habitTiles, {super.key});

  @override
  Widget build(BuildContext context) {
    final cardwidth = MediaQuery.of(context).size.width / 2 - 32;
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: cardwidth / 100,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: habitTiles.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(habitTiles[index]),
          child: habitTiles[index],
        );
      },
    );
  }
}

class HabitTile extends StatelessWidget {
  final String habitName;
  final String progress;
  final String streak;
  final IconData icon;
  final Color tileColor;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.progress,
    required this.streak,
    required this.icon,
    required this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tileColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: Icon(icon, color: Colors.black),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("1/3 Glasses", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  progress,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(streak, style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
