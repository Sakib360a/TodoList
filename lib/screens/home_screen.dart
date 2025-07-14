// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:todo_list/Navbar.dart';// Import your Navbar
import 'package:todo_list/screens/all_tasks_screen.dart';
import 'package:todo_list/screens/today_tasks_screen.dart';
import 'package:todo_list/screens/completed_tasks_screen.dart';
import 'package:todo_list/screens/settings_screen.dart';

// Enum to represent the different pages accessible from the drawer
enum AppPage {
  dashboard, // New
  allTasks,
  today,
  completed,
  settings,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppPage _currentPage = AppPage.dashboard; // Default to dashboard
  // ... rest of the state // Default page to show

  // Method to get the current page widget based on the enum
  Widget _getCurrentPageWidget() {
    switch (_currentPage) {
      case AppPage.allTasks:
        return const AllTasksScreen();
      case AppPage.today:
        return const TodayTasksScreen();
      case AppPage.completed:
        return const CompletedTasksScreen();
      case AppPage.settings:
        return const SettingsScreen();
      default:
        return const AllTasksScreen(); // Fallback
    }
  }

  // Method to get the current page title for the AppBar
  String _getCurrentPageTitle() {
    switch (_currentPage) {
      case AppPage.allTasks:
        return 'All Tasks';
      case AppPage.today:
        return 'Today\'s Tasks';
      case AppPage.completed:
        return 'Completed Tasks';
      case AppPage.settings:
        return 'Settings';
      default:
        return 'Todo List'; // Fallback title
    }
  }

  // Callback to be passed to Navbar to update the current page
  void _selectPage(AppPage page) {
    setState(() {
      _currentPage = page;
    });
    Navigator.pop(context); // Close the drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getCurrentPageTitle()),
        backgroundColor: Colors.orangeAccent, // Matching your original AppBar color
        centerTitle: true,                    // Matching your original AppBar style
        elevation: 5,                         // Matching your original AppBar style
        shadowColor: Colors.black,            // Matching your original AppBar style
      ),
      drawer: Navbar(
        onPageSelected: _selectPage,
        currentPage: _currentPage,
      ),
      body: _getCurrentPageWidget(),
      // Example of a global FloatingActionButton if needed:
      // floatingActionButton: _currentPage == AppPage.allTasks || _currentPage == AppPage.today
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           // Navigate to an AddTaskScreen or show a dialog
      //           // This FAB's action might need to be context-aware (e.g. pre-fill date for today)
      //           print("Global FAB tapped - current page: $_currentPage");
      //            if (_currentPage == AppPage.today) {
      //             // Potentially open AddTaskScreen with today's date pre-selected
      //           } else {
      //             // General AddTaskScreen
      //           }
      //         },
      //         backgroundColor: Colors.orangeAccent,
      //         child: Icon(Icons.add),
      //         tooltip: 'Add New Task',
      //       )
      //     : null, // No FAB on settings or completed tasks page, for example
    );
  }
}
