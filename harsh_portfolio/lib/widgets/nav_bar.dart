import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/responsive.dart';

class AppNavBar extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback? onContactTap;
  const AppNavBar({super.key, this.isScrolled = false, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 16 : 40,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: isScrolled
            ? theme.scaffoldBackgroundColor.withValues(alpha: 0.95)
            : Colors.transparent,
        border: isScrolled
            ? Border(
                bottom: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.1),
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'assets/icon.png',
                    width: 28,
                    height: 28,
                    errorBuilder: (_, __, ___) => const SizedBox(
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'HARSH',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              if (!Responsive.isMobile(context)) ...[
                _NavLink(
                  label: 'Home',
                  onTap: () => Navigator.pushNamed(context, '/'),
                ),
                const SizedBox(width: 24),
                _NavLink(
                  label: 'Projects',
                  onTap: () => Navigator.pushNamed(context, '/projects'),
                ),
                const SizedBox(width: 24),
                _NavLink(
                  label: 'Contact',
                  onTap: () {
                    if (onContactTap != null) {
                      onContactTap!();
                    } else {
                      Navigator.pushNamed(context, '/');
                    }
                  },
                ),
                const SizedBox(width: 24),
              ],
              IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  size: 20,
                ),
                onPressed: () {
                  PortfolioApp.themeNotifier.value =
                      isDark ? ThemeMode.light : ThemeMode.dark;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: _hovering
                ? theme.colorScheme.secondary
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
