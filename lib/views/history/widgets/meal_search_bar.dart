// Rounded search input for filtering meal history by name or type.
//
// ## Custom TextField styling
// Flutter's [TextField] comes with built-in Material borders and fill
// colours, but they don't always match a custom design.  The approach
// used here is:
//   1. Wrap the [TextField] in a styled [Container] (our own border,
//      radius, and surface colour).
//   2. Set `border`, `enabledBorder`, and `focusedBorder` on the
//      [InputDecoration] to `InputBorder.none` to remove all default
//      borders — the outer Container handles visual styling.
//   3. Use `contentPadding` to vertically centre the text.
//
// ## ValueChanged<String>
// [ValueChanged] is a typedef for `void Function(T)`.  Passing it as
// a constructor parameter lets the parent widget (the history screen)
// decide what happens when the user types — in our case, it calls
// `controller.setSearchQuery(query)`.
import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';

/// A search bar styled to match the SnackTrack design system.
///
/// Fires [onChanged] on every keystroke so the parent can update its
/// filter state in real time (no submit button required).
class MealSearchBar extends StatelessWidget {
  /// Callback fired on every keystroke with the current query string.
  final ValueChanged<String> onChanged;

  const MealSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        // Surface fill that distinguishes the bar from the scaffold
        // background.  Uses the same dark-surface / white pattern
        // as every other card in the app.
        color: isDark ? const Color(0xFF1A2236) : Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        // Thin border for definition — colours match CyberCortexColors
        // (dark) and LuminaColors (light) border tokens.
        border: Border.all(
          color: isDark ? const Color(0xFF2D3C57) : const Color(0xFFE2E8F0),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        // `tt.bodyMedium` picks up the font family and size from the
        // active theme so the search text matches the rest of the app.
        style: tt.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search your meals...',
          // Lower-alpha hint colour keeps it visible but unobtrusive.
          hintStyle: tt.bodyMedium?.copyWith(
            color: scheme.onSurface.withAlpha(100),
          ),
          // Leading search icon inside the field
          prefixIcon: Icon(
            Icons.search_rounded,
            color: scheme.onSurface.withAlpha(120),
            size: 22,
          ),
          // Remove ALL default Material borders — the Container
          // already provides our custom border and radius.
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          // Vertical padding centres the text within the 48 px height.
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
