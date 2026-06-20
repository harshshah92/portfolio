import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/project_data.dart';
import '../models/project_model.dart';
import '../utils/responsive.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String projectId;
  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 50;
      if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color _domainColor(String domain) {
    switch (domain) {
      case 'Healthcare':
        return const Color(0xFF10B981);
      case 'AI':
        return const Color(0xFF8B5CF6);
      case 'Hospitality':
        return const Color(0xFFF59E0B);
      case 'Logistics':
        return const Color(0xFF3B82F6);
      case 'Communication':
        return const Color(0xFFEC4899);
      case 'Finance':
        return const Color(0xFF06B6D4);
      case 'Gaming':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _domainIcon(String domain) {
    switch (domain) {
      case 'Healthcare':
        return Icons.local_hospital_rounded;
      case 'AI':
        return Icons.psychology_rounded;
      case 'Hospitality':
        return Icons.hotel_rounded;
      case 'Logistics':
        return Icons.local_shipping_rounded;
      case 'Communication':
        return Icons.chat_rounded;
      case 'Finance':
        return Icons.account_balance_wallet_rounded;
      case 'Gaming':
        return Icons.sports_esports_rounded;
      default:
        return Icons.code_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = ProjectData.getById(widget.projectId);

    if (project == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, size: 48),
              const SizedBox(height: 16),
              const Text('Project not found'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/projects'),
                child: const Text('Back to Projects'),
              ),
            ],
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    final domainColor = _domainColor(project.domain);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                _buildHeader(theme, project, domainColor, isMobile),
                _buildOverview(theme, project, isMobile),
                _buildTechStack(theme, project, isMobile),
                _buildFeatures(theme, project, isMobile),
                _buildArchitecture(theme, project, isMobile),
                _buildChallenges(theme, project, isMobile),
                _buildDeliverables(theme, project, isMobile),
                _buildMedia(theme, isMobile),
                const SizedBox(height: 40),
                const AppFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavBar(isScrolled: _isScrolled),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
      ThemeData theme, ProjectModel project, Color domainColor, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/projects'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  size: 16,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'All Projects',
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: domainColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _domainIcon(project.domain),
                  color: domainColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.05),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: domainColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  project.domain,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: domainColor,
                  ),
                ),
              ),
              if (project.isFeatured) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded,
                          size: 12, color: Color(0xFFF59E0B)),
                      SizedBox(width: 4),
                      Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverview(ThemeData theme, ProjectModel project, bool isMobile) {
    return _DetailSection(
      isMobile: isMobile,
      title: 'Project Overview',
      icon: Icons.info_outline_rounded,
      child: Text(
        project.overview,
        style: theme.textTheme.bodyLarge?.copyWith(
          height: 1.7,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms);
  }

  Widget _buildTechStack(ThemeData theme, ProjectModel project, bool isMobile) {
    return _DetailSection(
      isMobile: isMobile,
      title: 'Technology Stack',
      icon: Icons.code_rounded,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: project.techStack.map((tech) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.secondary.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              tech,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.secondary,
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  Widget _buildFeatures(ThemeData theme, ProjectModel project, bool isMobile) {
    return _DetailSection(
      isMobile: isMobile,
      title: 'Feature Highlights',
      icon: Icons.featured_play_list_rounded,
      child: Column(
        children: project.features.map((feature) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feature,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms);
  }

  Widget _buildArchitecture(
      ThemeData theme, ProjectModel project, bool isMobile) {
    return _DetailSection(
      isMobile: isMobile,
      title: 'Architecture Highlights',
      icon: Icons.architecture_rounded,
      child: Column(
        children: project.architectureHighlights.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 18,
                  color: theme.colorScheme.secondary.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 400.ms);
  }

  Widget _buildChallenges(
      ThemeData theme, ProjectModel project, bool isMobile) {
    return _DetailSection(
      isMobile: isMobile,
      title: 'Technical Challenges',
      icon: Icons.bolt_rounded,
      child: Column(
        children: project.technicalChallenges.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 500.ms);
  }

  Widget _buildDeliverables(
      ThemeData theme, ProjectModel project, bool isMobile) {
    return _DetailSection(
      isMobile: isMobile,
      title: 'Key Deliverables',
      icon: Icons.task_alt_rounded,
      child: Column(
        children: project.keyDeliverables.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_right_rounded,
                  size: 20,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 600.ms);
  }

  Widget _buildMedia(ThemeData theme, bool isMobile) {
    final project = ProjectData.getById(widget.projectId);
    if (project == null || project.screenshots.isEmpty) {
      return _DetailSection(
        isMobile: isMobile,
        title: 'Media',
        icon: Icons.perm_media_rounded,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.photo_library_rounded,
                size: 40,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 12),
              Text(
                'Images, Screenshots & Demo Videos',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Coming Soon',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 400.ms, delay: 700.ms);
    }

    return _DetailSection(
      isMobile: isMobile,
      title: 'Screenshots',
      icon: Icons.perm_media_rounded,
      child: _ScreenshotCarousel(
        screenshots: project.screenshots,
        height: isMobile ? 420 : 520,
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 700.ms);
  }
}

class _DetailSection extends StatelessWidget {
  final bool isMobile;
  final String title;
  final IconData icon;
  final Widget child;

  const _DetailSection({
    required this.isMobile,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 20,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.dividerColor.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: theme.colorScheme.secondary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _ScreenshotCarousel extends StatefulWidget {
  final List<String> screenshots;
  final double height;

  const _ScreenshotCarousel({
    required this.screenshots,
    required this.height,
  });

  @override
  State<_ScreenshotCarousel> createState() => _ScreenshotCarouselState();
}

class _ScreenshotCarouselState extends State<_ScreenshotCarousel> {
  final ScrollController _controller = ScrollController();

  void _scrollBy(double offset) {
    _controller.animateTo(
      (_controller.offset + offset).clamp(0, _controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _openFullScreen(int index) {
    showDialog(
      context: context,
      builder: (_) => _FullScreenViewer(
        screenshots: widget.screenshots,
        initialIndex: index,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: widget.height,
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.screenshots.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _openFullScreen(index),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.screenshots[index],
                      height: widget.height,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          child: _ArrowButton(
            icon: Icons.chevron_left_rounded,
            onTap: () => _scrollBy(-300),
          ),
        ),
        Positioned(
          right: 0,
          child: _ArrowButton(
            icon: Icons.chevron_right_rounded,
            onTap: () => _scrollBy(300),
          ),
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

class _FullScreenViewer extends StatefulWidget {
  final List<String> screenshots;
  final int initialIndex;

  const _FullScreenViewer({
    required this.screenshots,
    required this.initialIndex,
  });

  @override
  State<_FullScreenViewer> createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<_FullScreenViewer> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(
            child: Image.asset(
              widget.screenshots[_current],
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
            ),
          ),
          Positioned(
            bottom: 16,
            child: Text(
              '${_current + 1} / ${widget.screenshots.length}',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          if (_current > 0)
            Positioned(
              left: 8,
              child: _ArrowButton(
                icon: Icons.chevron_left_rounded,
                onTap: () => setState(() => _current--),
              ),
            ),
          if (_current < widget.screenshots.length - 1)
            Positioned(
              right: 8,
              child: _ArrowButton(
                icon: Icons.chevron_right_rounded,
                onTap: () => setState(() => _current++),
              ),
            ),
        ],
      ),
    );
  }
}
