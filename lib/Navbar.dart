import 'package:flutter/material.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'screens/all_tasks_screen.dart';
import 'screens/completed_tasks_screen.dart';
import 'screens/today_tasks_screen.dart';
class Navbar extends StatelessWidget {
  const Navbar({super.key, required void Function(AppPage page) onPageSelected, required AppPage currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Abu Bakkar Siddique"),
            accountEmail: Text("abubakkarsakib685@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://media.licdn.com/dms/image/v2/D5603AQEcKOfN60fsVw/profile-displayphoto-shrink_800_800/B56ZRfdrylHQAc-/0/1736768405121?e=1758153600&v=beta&t=4-TYDXbwe1_tge0M2cuzyCKUcqYbNjqr4ApNMMOByOE',
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage('https://img.freepik.com/premium-photo/mountain-range-with-full-moon-background_802346-465.jpg'),
                  fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('All Tasks'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.today_outlined),
            title: Text('Today'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> TodayTasksScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.done),
            title: Text('Completed Tasks'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedTasksScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
