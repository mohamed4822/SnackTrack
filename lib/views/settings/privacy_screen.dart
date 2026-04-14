import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';

class DataPrivacyScreen extends StatefulWidget {
  const DataPrivacyScreen({super.key});

  @override
  State<DataPrivacyScreen> createState() => _DataPrivacyScreenState();
}

class _DataPrivacyScreenState extends State<DataPrivacyScreen> {
  bool _anonymousAnalytics = true;
  bool _geoTracking        = false;
  bool _aiTrainingModel    = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tt     = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [

            // ── AppBar ────────────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1A2236) : Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 16),
                  ),
                ),
                Icon(Icons.notifications_outlined,
                    color: scheme.onSurface, size: 26),
              ],
            ),

            const SizedBox(height: 20),

            // ── Hero card ─────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A2236) : const Color(0xFF0F1629),
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  left: BorderSide(color: scheme.primary, width: 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data & Privacy',
                    style: tt.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your biometric data is encrypted and managed with bank-grade security protocols. You are in full control of your digital footprint.',
                    style: tt.bodySmall?.copyWith(
                        color: Colors.white60, height: 1.6),
                  ),
                  const SizedBox(height: 16),
                  // Badges
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Badge(
                        icon: Icons.shield_outlined,
                        label: 'AES-256 ENCRYPTED',
                        color: scheme.primary,
                      ),
                      _Badge(
                        icon: Icons.lock_outline_rounded,
                        label: 'GDPR COMPLIANT',
                        color: scheme.secondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Privacy Controls ──────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Privacy Controls',
                    style: tt.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  'ACTIVE PROTECTION',
                  style: tt.labelSmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _ControlCard(
              isDark: isDark,
              child: Column(
                children: [
                  _ToggleTile(
                    icon: Icons.visibility_off_outlined,
                    iconColor: scheme.primary,
                    title: 'Anonymous Analytics',
                    subtitle:
                        'Help improve NutriFit with anonymized usage data.',
                    value: _anonymousAnalytics,
                    onChanged: (v) =>
                        setState(() => _anonymousAnalytics = v),
                    isDark: isDark,
                  ),
                  _CardDivider(isDark: isDark),
                  _ToggleTile(
                    icon: Icons.gps_fixed_rounded,
                    iconColor: scheme.secondary,
                    title: 'Precision Geo-Tracking',
                    subtitle:
                        'Use high-accuracy GPS for workout mapping.',
                    value: _geoTracking,
                    onChanged: (v) =>
                        setState(() => _geoTracking = v),
                    isDark: isDark,
                  ),
                  _CardDivider(isDark: isDark),
                  _ToggleTile(
                    icon: Icons.psychology_outlined,
                    iconColor: scheme.primary,
                    title: 'AI Training Model',
                    subtitle:
                        'Allow AI to learn from your specific nutritional patterns.',
                    value: _aiTrainingModel,
                    onChanged: (v) =>
                        setState(() => _aiTrainingModel = v),
                    isDark: isDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Security Certifications ───────────────────────────────────────
            Text(
              'SECURITY CERTIFICATION',
              style: tt.labelSmall?.copyWith(
                color: scheme.onSurface.withOpacity(0.4),
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _CertBadge(icon: Icons.verified_user_outlined,  label: 'ISO 27001'),
                _CertBadge(icon: Icons.health_and_safety_outlined, label: 'HIPAA READY'),
                _CertBadge(icon: Icons.security_outlined,       label: 'SOC 2 TYPE II'),
                _CertBadge(icon: Icons.shield_outlined,         label: '256-BIT'),
              ],
            ),

            const SizedBox(height: 28),

            // ── Data Archives ─────────────────────────────────────────────────
            Text('Data Archives',
                style:
                    tt.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            _ControlCard(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Export My Data',
                      style: tt.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(
                    'Request a complete archive of your biometric, nutritional, and workout history.',
                    style: tt.bodySmall?.copyWith(
                        color:
                            scheme.onSurface.withOpacity(0.5),
                        height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _ExportButton(
                          icon: Icons.code_rounded,
                          label: 'JSON',
                          isDark: isDark,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ExportButton(
                          icon: Icons.grid_on_rounded,
                          label: 'CSV',
                          isDark: isDark,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Danger Zone ───────────────────────────────────────────────────
            Text(
              'Danger Zone',
              style: tt.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),

            _ControlCard(
              isDark: isDark,
              borderColor: Colors.red.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delete Account',
                      style: tt.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(
                    'Once deleted, your data cannot be recovered. This action is permanent and immediate.',
                    style: tt.bodySmall?.copyWith(
                        color:
                            scheme.onSurface.withOpacity(0.5),
                        height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: Colors.red.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => _showDeleteDialog(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          child: Center(
                            child: Text(
                              'Delete Account',
                              style: tt.labelLarge?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Footer note ───────────────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 14,
                    color: scheme.onSurface.withOpacity(0.35)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'NutriFit uses decentralized encryption keys. Our staff cannot access your raw biometric logs even if requested. Your privacy is mathematically guaranteed.',
                    style: tt.bodySmall?.copyWith(
                      color: scheme.onSurface.withOpacity(0.35),
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Account',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          'Are you sure? This action is permanent and cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: TextStyle(color: scheme.onSurface)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthController>().logout();
            },
            child: const Text('Delete',
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ── Badge ──────────────────────────────────────────────────────────────────────
class _Badge extends StatelessWidget {
  final IconData icon;
  final String   label;
  final Color    color;
  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Control card ───────────────────────────────────────────────────────────────
class _ControlCard extends StatelessWidget {
  final Widget child;
  final bool   isDark;
  final Color? borderColor;
  const _ControlCard(
      {required this.child, required this.isDark, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2236) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1)
            : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
      ),
      child: child,
    );
  }
}

// ── Toggle tile ────────────────────────────────────────────────────────────────
class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final Color    iconColor;
  final String   title;
  final String   subtitle;
  final bool     value;
  final bool     isDark;
  final ValueChanged<bool> onChanged;
  const _ToggleTile(
      {required this.icon,
      required this.iconColor,
      required this.title,
      required this.subtitle,
      required this.value,
      required this.onChanged,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 38, height: 38,
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
                Text(title,
                    style: tt.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: tt.bodySmall?.copyWith(
                        color: scheme.onSurface.withOpacity(0.45),
                        height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: scheme.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}

// ── Card divider ───────────────────────────────────────────────────────────────
class _CardDivider extends StatelessWidget {
  final bool isDark;
  const _CardDivider({required this.isDark});

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

// ── Certification badge ────────────────────────────────────────────────────────
class _CertBadge extends StatelessWidget {
  final IconData icon;
  final String   label;
  const _CertBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, color: scheme.onSurface.withOpacity(0.5), size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: scheme.onSurface.withOpacity(0.4),
            fontSize: 9,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ── Export button ──────────────────────────────────────────────────────────────
class _ExportButton extends StatelessWidget {
  final IconData icon;
  final String   label;
  final bool     isDark;
  final VoidCallback onTap;
  const _ExportButton(
      {required this.icon,
      required this.label,
      required this.isDark,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: isDark ? const Color(0xFF0F1629) : const Color(0xFFF4F4F4),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon, color: scheme.primary, size: 22),
              const SizedBox(height: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}