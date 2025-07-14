import 'package:flutter/material.dart';
// Assuming you have a Task model, replace 'your_app_name' with your actual project name
// and adjust the path if your Task model is elsewhere.
// import 'package:your_app_name/models/task_model.dart';

// --- Placeholder Task Model (if you don't have one yet) ---
// Remove or replace this with your actual Task model import
class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    this.isCompleted = false,
  });
}
// --- End of Placeholder Task Model ---


class TodayTasksScreen extends StatefulWidget {
  const TodayTasksScreen({super.key});

  @override
  State<TodayTasksScreen> createState() => _TodayTasksScreenState();
}

class _TodayTasksScreenState extends State<TodayTasksScreen> {
  // --- Placeholder Task Data ---
  // Replace this with your actual task fetching logic (e.g., from a database, API, state management)
  final List<Task> _allTasks = [
    Task(id: '1', title: 'Morning Standup Meeting', dueDate: DateTime.now()),
    Task(id: '2', title: 'Work on Flutter UI', dueDate: DateTime.now().subtract(const Duration(days: 1))), // Yesterday
    Task(id: '3', title: 'Grocery Shopping', dueDate: DateTime.now()),
    Task(id: '4', title: 'Submit Project Proposal', dueDate: DateTime.now().add(const Duration(days: 1))), // Tomorrow
    Task(id: '5', title: 'Read Flutter Documentation', dueDate: DateTime.now(), isCompleted: true),
    Task(id: '6', title: 'Gym Session', dueDate: DateTime.now()),
  ];
  // --- End of Placeholder Task Data ---

  List<Task> _todayTasks = [];

  @override
  void initState() {
    super.initState();
    _filterTasksForToday();
  }

  void _filterTasksForToday() {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day); // Midnight today
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59); // End of today

    setState(() {
      _todayTasks = _allTasks.where((task) {
        return !task.isCompleted && // Optionally, only show non-completed tasks
            task.dueDate.isAfter(todayStart.subtract(const Duration(microseconds: 1))) && // Due date is on or after midnight today
            task.dueDate.isBefore(todayEnd.add(const Duration(microseconds: 1)));      // Due date is before or at the end of today
      }).toList();
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      // After changing completion status, re-filter if you want completed tasks to disappear immediately
      _filterTasksForToday();
    });
    // Here you would also update your backend/database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(task.isCompleted ? '${task.title} marked as completed!' : '${task.title} marked as incomplete.')),
    );
  }

  void _deleteTask(Task task) {
    setState(() {
      _allTasks.removeWhere((t) => t.id == task.id); // Remove from the source list
      _filterTasksForToday(); // Re-filter
    });
    // Here you would also delete from your backend/database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${task.title} deleted.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Tasks'),
        // If you want a specific back button or other actions, add them here
        // leading: IconButton( // Example: Custom back button if not using drawer's default
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: _todayTasks.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.green[700]),
            const SizedBox(height: 20),
            const Text(
              'No tasks due today!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enjoy your day or add some new tasks.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _todayTasks.length,
        itemBuilder: (context, index) {
          final task = _todayTasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) {
                  _toggleTaskCompletion(task);
                },
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  color: task.isCompleted ? Colors.grey : null,
                ),
              ),
              subtitle: task.description.isNotEmpty
                  ? Text(
                task.description,
                style: TextStyle(
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  color: task.isCompleted ? Colors.grey : null,
                ),
              )
                  : null,
              trailing: IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red[300]),
                onPressed: () => _deleteTask(task),
              ),
              onTap: () {
                // Optional: Navigate to a task detail screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)));
                print('Tapped on ${task.title}');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement logic to add a new task
          // This might open a dialog or navigate to a new task screen
          print('Add new task for today');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new task functionality not implemented yet.')),
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
