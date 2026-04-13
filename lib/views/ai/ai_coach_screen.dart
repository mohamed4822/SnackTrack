import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/ai_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ai_coach_screen.dart
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
    final tt     = Theme.of(context).textTheme;

    return Scaffold(
      // ── AppBar: gives back arrow automatically when pushed via GoRouter ────
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: scheme.primary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            // Small gradient brain icon
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [scheme.primary, scheme.secondary],
                ),
              ),
              child: const Icon(Icons.psychology_outlined,
                  color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Snake AI ',
                    style: tt.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: 'Coach',
                    style: tt.headlineMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // LIVE badge
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: scheme.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: scheme.primary.withAlpha(100)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6, height: 6,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'LIVE',
                  style: tt.labelSmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Column(
        children: [
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
        Container(
          width: 90, height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end:   Alignment.bottomRight,
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
            child: Icon(Icons.psychology_outlined,
                color: scheme.primary, size: 40),
          ),
        ),
        const SizedBox(height: 16),
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
  final String message;

  const _AiMessage({required this.time, required this.message});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            border: Border(left: BorderSide(color: scheme.primary, width: 3)),
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
            border:
                Border(right: BorderSide(color: scheme.secondary, width: 3)),
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
        border: Border(left: BorderSide(color: scheme.primary, width: 3)),
        boxShadow: isDark
            ? null
            : [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: _HighlightedText(
              raw:
                  'Correct assessment. Your biometric feedback indicates a {glucose dip}. Recommended adjustment:',
              baseStyle: tt.bodyLarge!,
              highlightStyle: tt.bodyLarge!.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
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
                      style: tt.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(scheme.primary),
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

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border:
            Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
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
                  child: Icon(Icons.arrow_forward_rounded,
                      color: scheme.onPrimary, size: 20),
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
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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

// ─── Highlighted text parser ──────────────────────────────────────────────────
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
        spans.add(TextSpan(
            text: raw.substring(last, match.start), style: baseStyle));
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