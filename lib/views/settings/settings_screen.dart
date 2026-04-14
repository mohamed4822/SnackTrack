import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/setting_controller.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auth = context.read<AuthController>();
    final settings = context.watch<SettingsController>();

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F1629)
          : const Color(0xFFF4F4F4),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Replace your AppBar row with this:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // ← Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1A2236)
                              : Colors.black87,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Settings',
                      style: tt.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.notifications_outlined,
                  color: scheme.onSurface,
                  size: 26,
                ),
              ],
            ),
            SizedBox(height: 20,),
            // ── Premium card ──────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B4DB), Color(0xFF6A3DE8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.verified, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'PREMIUM ACTIVE',
                        style: tt.labelSmall?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'NutriFit AI Plus\nMember',
                    style: tt.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You have full access to AI meal analysis, advanced reports, and personalized nutrition coaching.',
                    style: tt.bodySmall?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white54, width: 1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Manage Subscription',
                      style: tt.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Appearance card ───────────────────────────────────────────────
            _SectionCard(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(
                    icon: Icons.wb_sunny_outlined,
                    label: 'Appearance',
                    iconColor: const Color(0xFF00B4DB),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose how NutriFit looks on your device.',
                    style: tt.bodySmall?.copyWith(
                      color: scheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Light / Dark toggle buttons
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF0F1629)
                          : const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _ThemeToggleBtn(
                          label: 'Light',
                          icon: Icons.wb_sunny_outlined,
                          isSelected: !settings.isDarkMode,
                          isDark: isDark,
                          onTap: () => settings.setDarkMode(false),
                        ),
                        _ThemeToggleBtn(
                          label: 'Dark',
                          icon: Icons.nightlight_round,
                          isSelected: settings.isDarkMode,
                          isDark: isDark,
                          onTap: () => settings.setDarkMode(true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Notifications card ────────────────────────────────────────────
            _SectionCard(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    iconColor: scheme.secondary,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Adjust alert frequency for activity updates.',
                    style: tt.bodySmall?.copyWith(
                      color: scheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Slider
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 7,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                      activeTrackColor: scheme.primary,
                      inactiveTrackColor: scheme.primary.withOpacity(0.15),
                      thumbColor: scheme.primary,
                    ),
                    child: Slider(
                      value: settings.notifFrequency,
                      min: 0,
                      max: 2,
                      divisions: 2,
                      onChanged: (v) => settings.setNotifFrequency(v),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['QUIET', 'STANDARD', 'FREQUENT']
                          .map(
                            (label) => Text(
                              label,
                              style: tt.labelSmall?.copyWith(
                                color: scheme.onSurface.withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                fontSize: 10,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Security & account card ───────────────────────────────────────
            _SectionCard(
              isDark: isDark,
              child: Column(
                children: [
                  // Two-Factor Auth
                  _AccountTile(
                    icon: Icons.security_outlined,
                    iconColor: const Color(0xFF00B4DB),
                    title: 'Two-Factor Authentication',
                    subtitle: 'Enhanced security for your account',
                    isDark: isDark,
                    trailing: Text(
                      'Enabled',
                      style: tt.labelMedium?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {},
                  ),
                  _Divider(isDark: isDark),

                  // Change Password
                  _AccountTile(
                    icon: Icons.lock_outline_rounded,
                    iconColor: const Color(0xFF6A3DE8),
                    title: 'Change Password',
                    subtitle: 'Update your account credentials',
                    isDark: isDark,
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: scheme.onSurface.withOpacity(0.3),
                    ),
                    onTap: () {},
                  ),
                  _Divider(isDark: isDark),
                  // Log Out
                  _AccountTile(
                    icon: Icons.logout_rounded,
                    iconColor: Colors.red,
                    title: 'Log Out',
                    subtitle: 'End your current session',
                    titleColor: Colors.red,
                    isDark: isDark,
                    trailing: const SizedBox.shrink(),
                    onTap: auth.logout,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Version footer ────────────────────────────────────────────────
            Center(
              child: Text(
                'NUTRIFIT AI V1.0.0 • BUILD 1001',
                style: tt.labelSmall?.copyWith(
                  color: scheme.onSurface.withOpacity(0.3),
                  letterSpacing: 1.2,
                  fontSize: 10,
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Section card wrapper ───────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final Widget child;
  final bool isDark;
  const _SectionCard({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2236) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: child,
    );
  }
}

// ── Section header (icon + title) ─────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final bool isDark;
  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// ── Theme toggle button ────────────────────────────────────────────────────────
class _ThemeToggleBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;
  const _ThemeToggleBtn({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF1A2236) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected && !isDark
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected
                    ? scheme.primary
                    : scheme.onSurface.withOpacity(0.4),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? scheme.onSurface
                      : scheme.onSurface.withOpacity(0.4),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Account tile ───────────────────────────────────────────────────────────────
class _AccountTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget trailing;
  final bool isDark;
  final Color? titleColor;
  final VoidCallback onTap;

  const _AccountTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.isDark,
    required this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: tt.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.45),
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Divider ────────────────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: isDark
          ? Colors.white.withOpacity(0.06)
          : Colors.black.withOpacity(0.06),
    );
  }
}
