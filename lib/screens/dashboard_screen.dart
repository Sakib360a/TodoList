// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
// Import any models or services you need for summary data
// import 'package:todo_list/models/task_model.dart'; // Example
// import 'package:todo_list/services/task_service.dart'; // Example

// You'll likely need access to the _selectPage method from HomeScreen
// to navigate when dashboard cards are tapped.
// One way is to pass it as a parameter if DashboardScreen is directly
// part of HomeScreen's build logic.
// Or use a more robust state management solution for navigation commands.
import 'package:todo_list/screens/home_screen.dart'; // For AppPage enum


class DashboardScreen extends StatefulWidget {
  final Function(AppPage) onNavigate; // Callback to navigate to other pages

  const DashboardScreen({super.key, required this.onNavigate});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Placeholder data for summary - In a real app, fetch this
  int _pendingTasksCount = 0;
  int _dueTodayCount = 0;
  int _completedThisWeekCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSummaryData();
  }

  void _loadSummaryData() {
    // TODO: Replace with actual data fetching logic
    // This would typically involve:
    // 1. Accessing your task list (from a service, state management, etc.)
    // 2. Filtering tasks to get counts for:
    //    - All pending tasks
    //    - Tasks due today
    //    - Tasks completed recently (e.g., this week)
    setState(() {
      _pendingTasksCount = 5; // Example
      _dueTodayCount = 2;    // Example
      _completedThisWeekCount = 10; // Example
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Welcome Back!', // Or "Hello, [User Name]!"
            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s your task overview:',
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 24),

          // Summary Cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true, // Important for GridView inside SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1.2, // Adjust for card proportions
            children: <Widget>[
              _buildSummaryCard(
                context: context,
                title: 'Pending Tasks',
                count: _pendingTasksCount,
                icon: Icons.list_alt_rounded,
                color: Colors.blueAccent,
                onTap: () => widget.onNavigate(AppPage.allTasks), // Navigate to All Tasks
              ),
              _buildSummaryCard(
                context: context,
                title: 'Due Today',
                count: _dueTodayCount,
                icon: Icons.today_outlined,
                color: Colors.orangeAccent,
                onTap: () => widget.onNavigate(AppPage.today), // Navigate to Today's Tasks
              ),
              _buildSummaryCard(
                context: context,
                title: 'Completed This Week',
                count: _completedThisWeekCount,
                icon: Icons.check_circle_outline,
                color: Colors.green,
                onTap: () => widget.onNavigate(AppPage.completed), // Navigate to Completed
              ),
              _buildSummaryCard(
                context: context,
                title: 'Settings',
                icon: Icons.settings_outlined,
                color: Colors.grey,
                onTap: () => widget.onNavigate(AppPage.settings), // Navigate to Settings
                showCount: false, // Don't show a count for settings
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Quick Actions or Recent Tasks (Optional)
          Text(
            'Quick Actions',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _buildQuickAction(
            context,
            icon: Icons.add_circle_outline,
            label: 'Add New Task',
            onTap: () {
              // TODO: Implement Add Task functionality (e.g., show dialog or navigate)
              print('Add new task tapped from dashboard');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add Task from dashboard not implemented yet.')),
              );
            },
          ),
          // You could add more quick actions or a list of a few upcoming/recent tasks here

        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required BuildContext context,
    required String title,
    int count = 0,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool showCount = true,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 36, color: color),
              const Spacer(),
              if (showCount)
                Text(
                  count.toString(),
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: color),
                ),
              const SizedBox(height: 4),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[800]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: ListTile(
        leading: Icon(icon, color: theme.primaryColor),
        title: Text(label, style: theme.textTheme.titleMedium),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
      ),
    );
  }
}
