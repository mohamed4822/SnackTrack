import 'package:flutter/material.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'views/dashboard/dashboard_screen.dart';
import 'views/history/meal_history_screen.dart';
import 'views/meal_logging/add_meal_screen.dart';
import 'views/reports/weekly_report_screen.dart';
import 'views/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required int initialIndex});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NavItem _current = NavItem.dashboard;

  Widget get _screen => switch (_current) {
    NavItem.dashboard => const DashboardScreen(),
    NavItem.history => const MealHistoryScreen(),
    NavItem.addMeal => const AddMealScreen(),
    NavItem.reports => const WeeklyReportScreen(),
    NavItem.profile => const ProfileScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor, 
        elevation: 0,
        scrolledUnderElevation: 0, 
        leading: Container(
          margin: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/person.png"),
              fit: BoxFit.fill,
            ),
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        title: Text(
          'SnakeTrack',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.primary, 
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: Theme.of(
                context,
              ).colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _screen,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _current,
        onTap: (item) => setState(() => _current = item),
      ),
    );
  }
}
