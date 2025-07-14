import 'package:flutter/material.dart';
// Assuming you have a Task model, replace 'todo_list' if your project name is different
// and adjust the path if your Task model is elsewhere.
// import 'package:todo_list/models/task_model.dart';

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

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  // --- Placeholder Task Data ---
  // Replace this with your actual task fetching logic
  final List<Task> _tasks = [
    Task(id: '1', title: 'Buy groceries', dueDate: DateTime.now().add(const Duration(days: 1))),
    Task(id: '2', title: 'Finish report', dueDate: DateTime.now(), isCompleted: true),
    Task(id: '3', title: 'Call John', dueDate: DateTime.now().add(const Duration(days: 2))),
    Task(id: '4', title: 'Plan weekend trip', dueDate: DateTime.now().add(const Duration(days: 5))),
    Task(id: '5', title: 'Read a chapter', dueDate: DateTime.now()),
  ];
  // --- End of Placeholder Task Data ---

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
    // Here you would also update your backend/database
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.removeWhere((t) => t.id == task.id);
    });
    // Here you would also delete from your backend/database
  }

  void _editTask(Task task) {
    // TODO: Implement navigation to an edit task screen or show an edit dialog
    print('Edit task: ${task.title}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit functionality for "${task.title}" not implemented yet.')),
    );
  }


  @override
  Widget build(BuildContext context) {
    // This is the content that will be placed in the body of HomeScreen's Scaffold
    if (_tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list_alt_rounded, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 20),
            const Text(
              'No tasks yet!',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap the + button to add your first task.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Card(
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) {
                _toggleTaskCompletion(task);
              },
              activeColor: Colors.orangeAccent,
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontSize: 17,
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? Colors.grey : Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        color: task.isCompleted ? Colors.grey : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Due: ${task.dueDate.toLocal().toString().split(' ')[0]}', // Simple date formatting
                    style: TextStyle(
                      fontSize: 12,
                      color: task.isCompleted ? Colors.grey : Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.grey[600]),
              onSelected: (String value) {
                if (value == 'edit') {
                  _editTask(task);
                } else if (value == 'delete') {
                  _deleteTask(task);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Edit'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete_outline, color: Colors.redAccent),
                    title: Text('Delete', style: TextStyle(color: Colors.redAccent)),
                  ),
                ),
              ],
            ),
            onTap: () {
              // Could navigate to a detailed task view or toggle completion
              _toggleTaskCompletion(task);
            },
          ),
        );
      },
    );
  }
}
