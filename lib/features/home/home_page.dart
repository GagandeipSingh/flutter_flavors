import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_config.dart';
import '../../config/config_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ConfigLoader.instance;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(config.appName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _FlavorBadge(flavor: config.flavor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _LogoSection(config: config),
            const SizedBox(height: 24),
            _BrandInfoCard(config: config),
            const SizedBox(height: 8),
            _ApiCard(config: config),
            const SizedBox(height: 8),
            _SupportCard(config: config),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () => _showFlavorDialog(context, config),
                icon: const Icon(Icons.info_outline),
                label: const Text('View Full Config'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showFlavorDialog(BuildContext context, AppConfig config) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${config.appName} Config'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ConfigRow(label: 'Flavor', value: config.flavor),
              _ConfigRow(label: 'App Name', value: config.appName),
              _ConfigRow(label: 'API URL', value: config.apiUrl),
              _ConfigRow(label: 'Primary', value: config.primaryColor),
              _ConfigRow(label: 'Secondary', value: config.secondaryColor),
              _ConfigRow(label: 'Support', value: config.supportEmail),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// ── Logo Section ────────────────────────────────────────────────────────────

class _LogoSection extends StatelessWidget {
  const _LogoSection({required this.config});
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        // Brand logo (SVG) + App icon (PNG) side by side
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // SVG brand logo — the in-app identity
            Column(
              children: [
                _ImageFrame(
                  size: 120,
                  radius: 24,
                  shadowColor: config.primaryColorValue,
                  child: SvgPicture.asset(
                    config.logoPath,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Brand Logo',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                ),
              ],
            ),
            const SizedBox(width: 28),
            // PNG app icon — what appears on the device home screen
            Column(
              children: [
                _ImageFrame(
                  size: 80,
                  radius: 18,
                  shadowColor: config.primaryColorValue,
                  child: Image.asset(
                    config.iconPath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'App Icon',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          config.appName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 6),
        Chip(label: Text('Flavor: ${config.flavor}')),
      ],
    );
  }
}

class _ImageFrame extends StatelessWidget {
  const _ImageFrame({
    required this.size,
    required this.radius,
    required this.shadowColor,
    required this.child,
  });

  final double size;
  final double radius;
  final Color shadowColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

// ── Info Cards ───────────────────────────────────────────────────────────────

class _BrandInfoCard extends StatelessWidget {
  const _BrandInfoCard({required this.config});
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(icon: Icons.palette_outlined, title: 'Brand Colors'),
            const SizedBox(height: 12),
            Row(
              children: [
                _ColorSwatch(label: 'Primary', color: config.primaryColorValue),
                const SizedBox(width: 12),
                _ColorSwatch(label: 'Secondary', color: config.secondaryColorValue),
                const SizedBox(width: 12),
                _ColorSwatch(label: 'Accent', color: config.accentColorValue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiCard extends StatelessWidget {
  const _ApiCard({required this.config});
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(icon: Icons.cloud_outlined, title: 'API Configuration'),
            const SizedBox(height: 12),
            _InfoRow(label: 'Base URL', value: config.apiUrl),
            const Divider(height: 20),
            _InfoRow(label: 'Website', value: config.websiteUrl),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard({required this.config});
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(icon: Icons.support_agent_outlined, title: 'Support & Legal'),
            const SizedBox(height: 12),
            _InfoRow(label: 'Email', value: config.supportEmail),
            const Divider(height: 20),
            _InfoRow(label: 'Terms', value: config.termsUrl),
            const Divider(height: 20),
            _InfoRow(label: 'Privacy', value: config.privacyUrl),
          ],
        ),
      ),
    );
  }
}

// ── Small Reusable Widgets ───────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
        ),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}

class _ConfigRow extends StatelessWidget {
  const _ConfigRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _FlavorBadge extends StatelessWidget {
  const _FlavorBadge({required this.flavor});
  final String flavor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Text(
        flavor,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
