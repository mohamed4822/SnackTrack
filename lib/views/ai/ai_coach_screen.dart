import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/ai_controller.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ai_coach_screen.dart
//
// Snake AI Coach chat screen.
// Follows project theme conventions (colorScheme, textTheme, cardColor,
// dividerColor, brightness checks) — identical pattern to profile_screen.dart
// ─────────────────────────────────────────────────────────────────────────────

class AiCoachScreen extends StatefulWidget {
  const AiCoachScreen({super.key});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  final TextEditingController _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // bottomNavigationBar: const _BottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar
            // _TopBar(),

            // ── Scrollable chat body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
                    SizedBox(height: 24),
                    _HeroSection(),
                    SizedBox(height: 28),
                    _AiMessage(
                      time: '14:02',
                      message:
                          'Analyzing your last 48 hours. Your {metabolic velocity} has increased by 12% following that Zone 2 session. How are your energy levels feeling right now?',
                    ),
                    SizedBox(height: 16),
                    _UserMessage(
                      time: '14:05',
                      message:
                          'Feeling a bit depleted. I think my glycogen levels are low after the morning fast.',
                    ),
                    SizedBox(height: 16),
                    _InsightCard(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ── Quick prompts + input bar
            _InputSection(),
          ],
        ),
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: scheme.primary, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Text(
                'SnakeTrack',
                style: tt.headlineMedium?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Icon(Icons.notifications_outlined,
                  color: scheme.onSurface.withAlpha(150), size: 24),
              Positioned(
                right: 0, top: 0,
                child: Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Hero Section ─────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return Column(
      children: [
        // Avatar with gradient ring + LIVE badge
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    scheme.primary.withAlpha(200),
                    scheme.secondary.withAlpha(200),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor,
                ),
                child: Icon(
                  Icons.psychology_outlined,
                  color: scheme.primary,
                  size: 44,
                ),
              ),
            ),
            Positioned(
              bottom: -2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'LIVE',
                  style: tt.labelSmall?.copyWith(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Snake AI ',
                style: tt.displayLarge?.copyWith(fontWeight: FontWeight.w300),
              ),
              TextSpan(
                text: 'Coach',
                style: tt.displayLarge?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your digital oracle for metabolic precision. Analyzing\nreal-time performance and nutritional velocity.',
          textAlign: TextAlign.center,
          style: tt.bodyMedium?.copyWith(
            color: scheme.onSurface.withAlpha(160),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ─── AI Message Bubble ────────────────────────────────────────────────────────
class _AiMessage extends StatelessWidget {
  final String time;
  final String message; // wrap {highlighted} in curly braces

  const _AiMessage({required this.time, required this.message});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row
        Row(
          children: [
            Text(
              'SNAKE AI',
              style: tt.labelSmall?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 8),
            Text(time, style: tt.labelSmall),
          ],
        ),
        const SizedBox(height: 8),
        // Bubble
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft:     Radius.circular(4),
              topRight:    Radius.circular(16),
              bottomLeft:  Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border(
              left: BorderSide(color: scheme.primary, width: 3),
            ),
            boxShadow: isDark
                ? null
                : [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 6)],
          ),
          child: _HighlightedText(
            raw: message,
            baseStyle: tt.bodyLarge!,
            highlightStyle: tt.bodyLarge!.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── User Message Bubble ──────────────────────────────────────────────────────
class _UserMessage extends StatelessWidget {
  final String time;
  final String message;

  const _UserMessage({required this.time, required this.message});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(time, style: tt.labelSmall),
            const SizedBox(width: 8),
            Text(
              'YOU',
              style: tt.labelSmall?.copyWith(
                color: scheme.secondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? scheme.secondary.withAlpha(40)
                : scheme.secondary.withAlpha(20),
            borderRadius: const BorderRadius.only(
              topLeft:     Radius.circular(16),
              topRight:    Radius.circular(4),
              bottomLeft:  Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border(
              right: BorderSide(color: scheme.secondary, width: 3),
            ),
          ),
          child: Text(message, style: tt.bodyLarge),
        ),
      ],
    );
  }
}

// ─── Insight Card ─────────────────────────────────────────────────────────────
class _InsightCard extends StatelessWidget {
  const _InsightCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: scheme.primary, width: 3),
        ),
        boxShadow: isDark
            ? null
            : [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Text(
              'SNAKE AI INSIGHT',
              style: tt.labelSmall?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
          // Body text
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: _HighlightedText(
              raw: 'Correct assessment. Your biometric feedback indicates a {glucose dip}. Recommended adjustment:',
              baseStyle: tt.bodyLarge!,
              highlightStyle: tt.bodyLarge!.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Optimal intake sub-card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? scheme.primary.withAlpha(20)
                    : scheme.primary.withAlpha(15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: scheme.primary.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.grain, color: scheme.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OPTIMAL INTAKE',
                        style: tt.labelSmall?.copyWith(letterSpacing: 1.2),
                      ),
                      Text(
                        '35g Complex Carbs',
                        style: tt.headlineMedium?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          // Recovery bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'METABOLIC RECOVERY',
                      style: tt.labelSmall?.copyWith(letterSpacing: 1),
                    ),
                    Text(
                      '88%',
                      style: tt.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.88,
                    minHeight: 6,
                    backgroundColor: scheme.primary.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Next window for peak performance: 16:30 (T-minus 2h)',
                  style: tt.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ─── Input Section ────────────────────────────────────────────────────────────
class _InputSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
          // Quick prompt chips
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _QuickChip(label: 'Analyze my dinner 🍕'),
                  const SizedBox(width: 10),
                  _QuickChip(label: 'Adjust macros for leg day 🏋'),
                ],
              ),
            ),
          ),
          // Text field row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Row(
              children: [
                Icon(Icons.attach_file_rounded,
                    color: scheme.onSurface.withAlpha(120), size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: tt.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Consult the Oracle...',
                      hintStyle: tt.bodyMedium?.copyWith(
                        color: scheme.onSurface.withAlpha(80),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.mic_none_rounded,
                    color: scheme.onSurface.withAlpha(120), size: 22),
                const SizedBox(width: 10),
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: scheme.onPrimary,
                    size: 20,
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

class _QuickChip extends StatelessWidget {
  final String label;
  const _QuickChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: scheme.primary.withAlpha(100)),
            color: scheme.primary.withAlpha(15),
          ),
          child: Text(
            label,
            style: tt.labelMedium?.copyWith(color: scheme.primary),
          ),
        ),
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
          _NavItem(icon: Icons.grid_view,         active: false, activeColor: scheme.primary),
          _NavItem(icon: Icons.history,            active: false, activeColor: scheme.primary),
          _NavItem(icon: Icons.add_circle_outline, active: false, activeColor: scheme.primary),
          _NavItem(icon: Icons.psychology_outlined,active: true,  activeColor: scheme.primary),
          _NavItem(icon: Icons.person_outline,     active: false, activeColor: scheme.primary),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool     active;
  final Color    activeColor;

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
            width: 4, height: 4,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
          ),
      ],
    );
  }
}

// ─── Utility: highlighted text parser ────────────────────────────────────────
// Wraps {text} in the highlight style, everything else in baseStyle.
class _HighlightedText extends StatelessWidget {
  final String    raw;
  final TextStyle baseStyle;
  final TextStyle highlightStyle;

  const _HighlightedText({
    required this.raw,
    required this.baseStyle,
    required this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\{([^}]+)\}');
    int last = 0;
    for (final match in regex.allMatches(raw)) {
      if (match.start > last) {
        spans.add(TextSpan(text: raw.substring(last, match.start), style: baseStyle));
      }
      spans.add(TextSpan(text: match.group(1), style: highlightStyle));
      last = match.end;
    }
    if (last < raw.length) {
      spans.add(TextSpan(text: raw.substring(last), style: baseStyle));
    }
    return RichText(text: TextSpan(children: spans));
  }
}