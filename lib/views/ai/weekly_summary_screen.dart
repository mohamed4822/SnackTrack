import 'dart:math';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// weekly_summary_screen.dart
//
// Weekly Performance Summary screen.
// Follows project theme conventions (colorScheme, textTheme, cardColor,
// dividerColor, brightness checks) — identical pattern to profile_screen.dart
// ─────────────────────────────────────────────────────────────────────────────

class WeeklySummaryScreen extends StatelessWidget {
  const WeeklySummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _HeroHeader(),
              SizedBox(height: 20),
              _GradeCard(),
              SizedBox(height: 14),
              _MetabolicHealthCard(),
              SizedBox(height: 14),
              _EnergyFluxCard(),
              SizedBox(height: 14),
              _NutrientSaturationCard(),
              SizedBox(height: 14),
              _OracleVerdictCard(),
              SizedBox(height: 14),
              _SystemLogsCard(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Hero Header ──────────────────────────────────────────────────────────────
class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WEEKLY PERFORMANCE SUMMARY',
          style: tt.labelSmall?.copyWith(
            color: scheme.primary,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Oct 23 — Oct 29',
          style: tt.displayLarge?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your metabolic efficiency is operating at peak levels. The AI has identified a 12% improvement in glucose stability compared to last week.',
          style: tt.bodyMedium?.copyWith(
            color: scheme.onSurface.withAlpha(160),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ─── Grade Card ───────────────────────────────────────────────────────────────
class _GradeCard extends StatelessWidget {
  const _GradeCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Center(
      child: SizedBox(
        width: 130,
        height: 130,
        child: CustomPaint(
          painter: _RingPainter(
            color: scheme.primary,
            trackColor: scheme.primary.withAlpha(30),
            progress: 0.92,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A',
                  style: tt.displayLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 44,
                    height: 1,
                  ),
                ),
                Text(
                  'OPTIMAL',
                  style: tt.labelSmall?.copyWith(letterSpacing: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  final Color trackColor;
  final double progress;

  const _RingPainter({
    required this.color,
    required this.trackColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 10.0;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progress * 2 * pi,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.color != color || old.progress != progress;
}

// ─── Shared Card ──────────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  final Widget child;
  final Color? accentBorder;

  const _Card({required this.child, this.accentBorder});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: accentBorder != null
            ? Border.all(color: accentBorder!, width: 1.5)
            : Border.all(color: Theme.of(context).dividerColor),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(18),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: child,
    );
  }
}

// ─── Metabolic Health Card ────────────────────────────────────────────────────
class _MetabolicHealthCard extends StatelessWidget {
  const _MetabolicHealthCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return _Card(
      accentBorder: scheme.primary.withAlpha(80),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Watermark icon
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.trending_up_rounded,
              size: 80,
              color: scheme.primary.withAlpha(isDark ? 18 : 12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.grid_on_rounded, color: scheme.primary, size: 18),
                  const SizedBox(width: 8),
                  Text('Metabolic Health Index', style: tt.headlineMedium),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'EFFICIENCY',
                style: tt.labelSmall?.copyWith(letterSpacing: 1.5),
              ),
              const SizedBox(height: 4),
              Text(
                '94.2%',
                style: tt.displayLarge?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your insulin sensitivity is trending upward. Excellent macro-timing observed on Wednesday.',
                style: tt.bodyMedium?.copyWith(
                  color: scheme.onSurface.withAlpha(160),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Energy Flux Card ─────────────────────────────────────────────────────────
class _EnergyFluxCard extends StatelessWidget {
  const _EnergyFluxCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bolt, color: scheme.tertiary, size: 20),
              const SizedBox(width: 6),
              Text('Energy Flux', style: tt.headlineMedium),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Sustained vitality levels across 16-hour active windows.',
            style: tt.bodySmall,
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'STABILITY',
                style: tt.labelSmall?.copyWith(letterSpacing: 1.2),
              ),
              Text(
                'High',
                style: tt.headlineMedium?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.82,
              minHeight: 5,
              backgroundColor: scheme.primary.withAlpha(30),
              valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nutrient Saturation Card ─────────────────────────────────────────────────
class _NutrientSaturationCard extends StatelessWidget {
  const _NutrientSaturationCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nutrient Saturation', style: tt.headlineMedium),
          const SizedBox(height: 14),
          _NutrientRow(
            icon: Icons.water_drop_outlined,
            iconColor: scheme.primary,
            name: 'Magnesium Glycinate',
            sub: '-12% vs Target',
            trailing: Icon(
              Icons.trending_down,
              color: Colors.red.shade400,
              size: 16,
            ),
          ),
          Divider(color: Theme.of(context).dividerColor, height: 20),
          _NutrientRow(
            icon: Icons.wb_sunny_outlined,
            iconColor: scheme.tertiary,
            name: 'Vitamin D3 + K2',
            sub: 'at Primal Levels',
            trailing: Icon(
              Icons.check_circle_outline,
              color: scheme.primary,
              size: 16,
            ),
          ),
          Divider(color: Theme.of(context).dividerColor, height: 20),
          _NutrientRow(
            icon: Icons.waves_rounded,
            iconColor: scheme.secondary,
            name: 'Omega-3 Index',
            sub: '+5% vs Last Week',
            trailing: Icon(Icons.trending_up, color: scheme.primary, size: 16),
          ),
          const SizedBox(height: 14),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'VIEW FULL MICRONUTRIENT MAP',
                  style: tt.labelSmall?.copyWith(
                    color: scheme.primary,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrientRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String name;
  final String sub;
  final Widget trailing;

  const _NutrientRow({
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.sub,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(sub, style: tt.bodySmall),
            ],
          ),
        ),
        trailing,
      ],
    );
  }
}

// ─── Oracle Verdict Card ──────────────────────────────────────────────────────
class _OracleVerdictCard extends StatelessWidget {
  const _OracleVerdictCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return _Card(
      accentBorder: scheme.secondary.withAlpha(80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: scheme.secondary, size: 18),
              const SizedBox(width: 8),
              Text("The Oracle's Verdict", style: tt.headlineMedium),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '"Your cortisol rhythms suggest a minor misalignment between 3 PM and 5 PM. We recommend shifting your complex carbohydrate intake 45 minutes earlier to buffer the afternoon dip."',
            style: tt.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: scheme.onSurface.withAlpha(180),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'STRATEGIC ADJUSTMENT',
            style: tt.labelSmall?.copyWith(
              color: scheme.secondary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          _AdjustmentRow(
            text:
                'Increase fiber intake by 8g during breakfast to extend satiety.',
            color: scheme.primary,
          ),
          const SizedBox(height: 8),
          _AdjustmentRow(
            text: 'Add 300mg Potassium to post-workout hydration.',
            color: scheme.primary,
          ),
        ],
      ),
    );
  }
}

class _AdjustmentRow extends StatelessWidget {
  final String text;
  final Color color;
  const _AdjustmentRow({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.arrow_forward_rounded, color: color, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: tt.bodyMedium?.copyWith(height: 1.4)),
        ),
      ],
    );
  }
}

// ─── System Logs Card ─────────────────────────────────────────────────────────
class _SystemLogsCard extends StatelessWidget {
  const _SystemLogsCard();

  static const _logs = [
    _LogEntry(
      day: 'Mon',
      date: 'Oct 23',
      title: 'Perfect Macro Alignment',
      sub: 'All targets met within 2% margin.',
      score: 98,
      scoreHigh: true,
    ),
    _LogEntry(
      day: 'Tue',
      date: 'Oct 24',
      title: 'Sodium Spike Detected',
      sub: 'Late-night intake exceeded threshold.',
      score: 72,
      scoreHigh: false,
    ),
    _LogEntry(
      day: 'Wed',
      date: 'Oct 25',
      title: 'Recovery Optimization',
      sub: 'Protein synthesis peak observed during sleep.',
      score: 91,
      scoreHigh: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('System Logs', style: tt.headlineMedium),
        const SizedBox(height: 14),
        ..._logs.map(
          (log) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _LogTile(entry: log),
          ),
        ),
      ],
    );
  }
}

class _LogEntry {
  final String day, date, title, sub;
  final int score;
  final bool scoreHigh;

  const _LogEntry({
    required this.day,
    required this.date,
    required this.title,
    required this.sub,
    required this.score,
    required this.scoreHigh,
  });
}

class _LogTile extends StatelessWidget {
  final _LogEntry entry;
  const _LogTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final scoreColor = entry.scoreHigh ? scheme.primary : Colors.red.shade400;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: isDark
            ? null
            : [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 6)],
      ),
      child: Row(
        children: [
          // Date column
          Column(
            children: [
              Text(
                entry.day,
                style: tt.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(entry.date, style: tt.labelSmall),
            ],
          ),
          // Vertical divider line
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            width: 2,
            height: 48,
            decoration: BoxDecoration(
              color: scoreColor.withAlpha(120),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(entry.sub, style: tt.bodySmall),
              ],
            ),
          ),
          // Score
          Text(
            '${entry.score}',
            style: tt.headlineMedium?.copyWith(
              color: scoreColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Nav ───────────────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.grid_view,
            active: false,
            activeColor: scheme.primary,
          ),
          _NavItem(
            icon: Icons.history,
            active: true,
            activeColor: scheme.primary,
          ),
          _NavItem(
            icon: Icons.add_circle_outline,
            active: false,
            activeColor: scheme.primary,
          ),
          _NavItem(
            icon: Icons.search,
            active: false,
            activeColor: scheme.primary,
          ),
          _NavItem(
            icon: Icons.person_outline,
            active: false,
            activeColor: scheme.primary,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final Color activeColor;

  const _NavItem({
    required this.icon,
    required this.active,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: active
              ? activeColor
              : Theme.of(context).colorScheme.onSurface.withAlpha(100),
          size: 22,
        ),
        if (active)
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
