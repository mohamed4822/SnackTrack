import 'dart:math';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// weekly_report_screen.dart
//
// Follows the same conventions as profile_screen.dart:
//   • Theme.of(context).colorScheme  for colors
//   • Theme.of(context).textTheme    for typography
//   • Theme.of(context).brightness   for light/dark surface colors
//   • Material + InkWell for tappable surfaces
//   • No hard-coded colors (except transparent / red for logout parity)
// ─────────────────────────────────────────────────────────────────────────────

class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const _BottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // _TopBar(),
              // SizedBox(height: 20),
              _Header(),
              SizedBox(height: 20),
              _WeightCard(),
              SizedBox(height: 14),
              _CaloricFluxCard(),
              SizedBox(height: 14),
              _MacroIntegrityCard(),
              SizedBox(height: 14),
              _OracleCard(),
              SizedBox(height: 14),
              _StatsGrid(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


// ─── Header ──────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PERFORMANCE OVERVIEW',
          style: tt.labelSmall?.copyWith(
            color: scheme.primary,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Weekly ',
                style: tt.displayLarge?.copyWith(fontWeight: FontWeight.w300),
              ),
              TextSpan(
                text: 'Report',
                style: tt.displayLarge?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: tt.bodyMedium,
            children: [
              const TextSpan(text: 'Your metabolic velocity increased by '),
              TextSpan(
                text: '4.2%',
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(
                text:
                    ' this week. Tracking consistency remains in the 95th percentile.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Shared Card ─────────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  final Widget child;
  final Color? borderColor;

  const _Card({required this.child, this.borderColor});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme  = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.5)
            : Border.all(color: theme.dividerColor),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: child,
    );
  }
}

// ─── Weight Card ─────────────────────────────────────────────────────────────
class _WeightCard extends StatelessWidget {
  const _WeightCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return _Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURRENT WEIGHT',
                style: tt.labelSmall?.copyWith(
                  color: scheme.onSurface.withAlpha(100),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '174.2',
                    style: tt.displayLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 38,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('lbs', style: tt.bodyMedium),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(30),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.withAlpha(80)),
            ),
            child: Row(
              children: [
                const Icon(Icons.trending_down, color: Colors.green, size: 14),
                const SizedBox(width: 4),
                Text(
                  '0.8',
                  style: tt.labelLarge?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Caloric Flux Card ───────────────────────────────────────────────────────
class _CaloricFluxCard extends StatelessWidget {
  const _CaloricFluxCard();

  static const List<double> intakeData = [2200, 2450, 2100, 2600, 2350, 2500, 2450];
  static const List<double> weightData = [175.0, 174.8, 175.2, 174.6, 174.4, 174.3, 174.2];
  static const List<String> days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Caloric Flux vs. Weight',
                      style: tt.headlineMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Correlation of intake against daily weigh-ins',
                      style: tt.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LegendDot(color: scheme.primary,   label: 'INTAKE'),
                  const SizedBox(height: 4),
                  _LegendDot(color: scheme.secondary, label: 'WEIGHT'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: CustomPaint(
              size: const Size(double.infinity, 120),
              painter: _DualLinePainter(
                intakeData: intakeData,
                weightData: weightData,
                primaryColor:   scheme.primary,
                secondaryColor: scheme.secondary,
                surfaceColor:   Theme.of(context).cardColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days
                .map((d) => Text(d, style: tt.labelSmall))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 8, height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: tt.labelSmall),
      ],
    );
  }
}

class _DualLinePainter extends CustomPainter {
  final List<double> intakeData;
  final List<double> weightData;
  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;

  const _DualLinePainter({
    required this.intakeData,
    required this.weightData,
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfaceColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawLine(canvas, size, intakeData, primaryColor,   dashed: false);
    _drawLine(canvas, size, weightData, secondaryColor, dashed: true);
  }

  void _drawLine(Canvas canvas, Size size, List<double> data, Color color,
      {bool dashed = false}) {
    final minVal = data.reduce(min);
    final maxVal = data.reduce(max);
    final range  = maxVal - minVal == 0 ? 1 : maxVal - minVal;

    Offset getOffset(int i) {
      final x = i * size.width / (data.length - 1);
      final y = size.height -
          ((data[i] - minVal) / range) * (size.height * 0.8) -
          size.height * 0.1;
      return Offset(x, y);
    }

    // Gradient fill (solid lines only)
    if (!dashed) {
      final fillPath = Path()..moveTo(0, size.height);
      for (int i = 0; i < data.length; i++) {
        final o = getOffset(i);
        if (i == 0) {
          fillPath.lineTo(o.dx, o.dy);
        } else {
          final prev = getOffset(i - 1);
          final cp1  = Offset((prev.dx + o.dx) / 2, prev.dy);
          final cp2  = Offset((prev.dx + o.dx) / 2, o.dy);
          fillPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, o.dx, o.dy);
        }
      }
      fillPath
        ..lineTo(size.width, size.height)
        ..close();

      canvas.drawPath(
        fillPath,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end:   Alignment.bottomCenter,
            colors: [color.withAlpha(70), color.withAlpha(0)],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
      );
    }

    // Build smooth path
    final linePath = Path();
    for (int i = 0; i < data.length; i++) {
      final o = getOffset(i);
      if (i == 0) {
        linePath.moveTo(o.dx, o.dy);
      } else {
        final prev = getOffset(i - 1);
        final cp1  = Offset((prev.dx + o.dx) / 2, prev.dy);
        final cp2  = Offset((prev.dx + o.dx) / 2, o.dy);
        linePath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, o.dx, o.dy);
      }
    }

    final linePaint = Paint()
      ..color       = color
      ..strokeWidth = 2.5
      ..strokeCap   = StrokeCap.round
      ..style       = PaintingStyle.stroke;

    if (dashed) {
      _drawDashedPath(canvas, linePath, linePaint);
    } else {
      canvas.drawPath(linePath, linePaint);
    }

    // Dots
    for (int i = 0; i < data.length; i++) {
      canvas.drawCircle(getOffset(i), 3.5, Paint()..color = color);
      canvas.drawCircle(
        getOffset(i), 3.5,
        Paint()
          ..color       = surfaceColor
          ..style       = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DualLinePainter old) =>
      old.primaryColor != primaryColor || old.secondaryColor != secondaryColor;
}

// ─── Macro Integrity Card ────────────────────────────────────────────────────
class _MacroIntegrityCard extends StatelessWidget {
  const _MacroIntegrityCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Macro Integrity', style: tt.headlineMedium),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 140, height: 140,
              child: CustomPaint(
                painter: _DonutPainter(
                  primaryColor:   scheme.primary,
                  secondaryColor: scheme.secondary,
                  tertiaryColor:  scheme.tertiary,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '92%',
                        style: tt.displayMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'ADHERENCE',
                        style: tt.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _MacroRow(label: 'PROTEIN', value: '185g', color: scheme.primary),
          const SizedBox(height: 10),
          _MacroRow(label: 'CARBS',   value: '210g', color: scheme.secondary),
          const SizedBox(height: 10),
          _MacroRow(label: 'FATS',    value: '65g',  color: scheme.tertiary),
        ],
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  final String label;
  final String value;
  final Color  color;
  const _MacroRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: tt.bodyMedium),
        Text(
          value,
          style: tt.labelLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  const _DonutPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center      = Offset(size.width / 2, size.height / 2);
    final radius      = size.width / 2 - 8;
    const strokeWidth = 14.0;
    const gapAngle    = 0.08;

    final segments = [
      (0.40, primaryColor),
      (0.33, secondaryColor),
      (0.19, tertiaryColor),
    ];

    double startAngle = -pi / 2;
    for (final seg in segments) {
      final sweepAngle = seg.$1 * 2 * pi - gapAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false,
        Paint()
          ..color       = seg.$2
          ..style       = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap   = StrokeCap.round,
      );
      startAngle += sweepAngle + gapAngle;
    }

    // Remaining track
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle, (1 - 0.92) * 2 * pi, false,
      Paint()
        ..color       = primaryColor.withAlpha(40)
        ..style       = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) =>
      old.primaryColor   != primaryColor   ||
      old.secondaryColor != secondaryColor ||
      old.tertiaryColor  != tertiaryColor;
}

// ─── Oracle Card ─────────────────────────────────────────────────────────────
class _OracleCard extends StatelessWidget {
  const _OracleCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.primary.withAlpha(70)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: scheme.primary.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.auto_awesome, color: scheme.primary, size: 16),
              ),
              const SizedBox(width: 8),
              Text('Digital Oracle Analysis', style: tt.headlineMedium),
            ],
          ),
          const SizedBox(height: 14),
          RichText(
            text: TextSpan(
              style: tt.bodyMedium,
              children: [
                const TextSpan(text: 'Your '),
                TextSpan(
                  text: 'thermic effect of food (TEF)',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text:
                      ' was optimized this week by increasing protein intake during your first meal. This shift correlates with a 15% reduction in afternoon lethargy reports.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'The weight fluctuation observed on Wednesday (Day 3) is categorized as transient water retention, likely due to the sodium-rich meal logged on Tuesday night. By Thursday, your baseline trend returned to the projected trajectory.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 14),
          Text(
            'RECOMMENDATION:',
            style: tt.labelSmall?.copyWith(
              color: scheme.primary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '"Maintain current macros for another 4 days to solidify this metabolic floor before adjusting deficit variables."',
            style: tt.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Grid ──────────────────────────────────────────────────────────────
class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        _StatTile(
          icon: Icons.local_fire_department_outlined,
          iconColor: scheme.tertiary,
          label: 'AVG CALORIES',
          value: '2,450',
        ),
        _StatTile(
          icon: Icons.bolt,
          iconColor: scheme.primary,
          label: 'ENERGY PEAK',
          value: '88%',
        ),
        _StatTile(
          icon: Icons.water_drop_outlined,
          iconColor: scheme.primary,
          label: 'HYDRATION',
          value: '3.2L',
        ),
        _StatTile(
          icon: Icons.bedtime_outlined,
          iconColor: scheme.secondary,
          label: 'SLEEP QUALITY',
          value: '7.5h',
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color    iconColor;
  final String   label;
  final String   value;

  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: tt.labelSmall,
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: tt.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

