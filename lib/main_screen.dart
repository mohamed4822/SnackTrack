import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_assistant/views/ai/weekly_summary_screen.dart';
import 'core/constants/app_routes.dart';
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

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  NavItem _current = NavItem.dashboard;

  // Animation controller for the FAB pulse effect
  late final AnimationController _fabPulse;
  late final Animation<double>   _fabScale;

  @override
  void initState() {
    super.initState();
    _fabPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _fabScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _fabPulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fabPulse.dispose();
    super.dispose();
  }

  Widget get _screen => switch (_current) {
        NavItem.dashboard => const DashboardScreen(),
        NavItem.history   => const MealHistoryScreen(),
        NavItem.addMeal   => const AddMealScreen(),
        NavItem.reports   => const WeeklyReportScreen(),
        NavItem.profile   => const ProfileScreen(),
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/person.png"),
              fit: BoxFit.fill,
            ),
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        title: Text(
          'SnakeTrack',
          style: tt.displayMedium?.copyWith(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: _screen,

      // ── Floating Action Button → AI Coach ──────────────────────────────────
      floatingActionButton: ScaleTransition(
        scale: _fabScale,
        child: _AiCoachFab(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavBar(
        currentIndex: _current,
        onTap: (item) => setState(() => _current = item),
      ),
    );
  }
}

// ─── AI Coach FAB ─────────────────────────────────────────────────────────────
class _AiCoachFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.aiCoach),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.primary, scheme.secondary],
            begin: Alignment.centerLeft,
            end:   Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color:      scheme.primary.withAlpha(100),
              blurRadius: 16,
              offset:     const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.psychology_outlined, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              'AI Coach',
              style: tt.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}