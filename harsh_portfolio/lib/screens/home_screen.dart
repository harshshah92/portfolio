import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/project_data.dart';
import '../utils/responsive.dart';
import '../widgets/nav_bar.dart';
import '../widgets/section_title.dart';
import '../widgets/project_card.dart';
import '../widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80),
                _HeroSection(),
                _StatsSection(),
                _CareerSection(),
                _SkillsSection(),
                _FeaturedProjectsSection(),
                _TechnologyShowcaseSection(),
                _DownloadSection(),
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
      floatingActionButton: Responsive.isMobile(context)
          ? FloatingActionButton.small(
              onPressed: () => Navigator.pushNamed(context, '/projects'),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child:
                  const Icon(Icons.grid_view_rounded, color: Colors.white, size: 18),
            )
          : null,
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HARSH',
            style: theme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: isMobile ? 48 : 72,
              letterSpacing: -2,
              height: 1.1,
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
          const SizedBox(height: 12),
          Text(
            'Senior Mobile & Full Stack Engineer',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 700),
            child: Text(
              'Results-driven Senior Engineer with 9+ years of hands-on experience architecting and delivering enterprise-grade mobile and full-stack applications. Specialized in cross-platform mobile development using Xamarin.Forms, .NET MAUI, and Flutter, coupled with robust backend systems built on ASP.NET Core, FastAPI, SQL Server, and Supabase. Passionate about integrating AI/ML capabilities into production applications using Python, Ollama, and modern LLM frameworks. Proven track record across healthcare, hospitality, logistics, finance, and real-time communication domains.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.7,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          const SizedBox(height: 32),
          Row(
            children: [
              _HeroButton(
                label: 'View Projects',
                onTap: () => Navigator.pushNamed(context, '/projects'),
                isPrimary: true,
              ),
              const SizedBox(width: 12),
              _HeroButton(
                label: 'Download PDF',
                onTap: () => _downloadPdf(),
                isPrimary: false,
              ),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
        ],
      ),
    );
  }

  void _downloadPdf() {
    launchUrl(Uri.parse('assets/assets/Harsh_Portfolio.pdf'));
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _HeroButton({
    required this.label,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? theme.colorScheme.secondary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.isPrimary
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.2),
            ),
            boxShadow: _hovering && widget.isPrimary
                ? [
                    BoxShadow(
                      color: theme.colorScheme.secondary.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: widget.isPrimary
                  ? Colors.white
                  : theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    final stats = [
      {'value': '9+', 'label': 'Years Experience'},
      {'value': '10+', 'label': 'Projects Delivered'},
      {'value': '5', 'label': 'Platforms'},
      {'value': '3+', 'label': 'AI Projects'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 40,
      ),
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        children: stats.map((stat) {
          return SizedBox(
            width: isMobile ? (MediaQuery.of(context).size.width - 72) / 2 : 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat['value']!,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stat['label']!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms);
  }
}

class _CareerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final careers = [
      {
        'role': 'Senior Software Engineer',
        'period': 'Jan 2026 – Present',
        'description':
            'Leading architecture & development of enterprise mobile apps, AI integration, and full-stack solutions.',
        'technologies': '.NET MAUI, Flutter, FastAPI, AI/ML, Ollama, Supabase',
      },
      {
        'role': 'Xamarin Developer',
        'period': 'Jan 2022 – Dec 2025',
        'description':
            'Designed and delivered cross-platform mobile applications for healthcare, logistics, and hospitality using Xamarin.Forms & .NET MAUI.',
        'technologies': 'Xamarin.Forms, .NET MAUI, C#, ASP.NET Core, SQL Server',
      },
      {
        'role': 'Associate Software Engineer',
        'period': 'Jun 2017 – Dec 2021',
        'description':
            'Built foundational mobile and backend systems, REST APIs, database design, and client-facing applications.',
        'technologies': 'C#, ASP.NET, SQL Server, REST APIs, Mobile Development',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Career Journey',
            subtitle: 'Professional experience and growth',
          ),
          const SizedBox(height: 40),
          ...careers.asMap().entries.map((entry) {
            final i = entry.key;
            final career = entry.value;
            return _CareerCard(
              role: career['role']!,
              period: career['period']!,
              description: career['description']!,
              technologies: career['technologies']!,
              isFirst: i == 0,
              isLast: i == careers.length - 1,
            ).animate().fadeIn(duration: 400.ms, delay: (200 * i).ms).slideX(begin: -0.05);
          }),
        ],
      ),
    );
  }
}

class _CareerCard extends StatelessWidget {
  final String role;
  final String period;
  final String description;
  final String technologies;
  final bool isFirst;
  final bool isLast;

  const _CareerCard({
    required this.role,
    required this.period,
    required this.description,
    required this.technologies,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: theme.colorScheme.secondary.withValues(alpha: 0.3),
                    ),
                  ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFirst
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.secondary.withValues(alpha: 0.4),
                    border: Border.all(
                      color: theme.colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: theme.colorScheme.secondary.withValues(alpha: 0.3),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          role,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        period,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: technologies.split(', ').map((t) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          t,
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final skills = {
      'Mobile': ['.NET MAUI', 'Xamarin.Forms', 'Flutter', 'Dart', 'C#', 'MVVM'],
      'Backend': ['ASP.NET Core', 'FastAPI', 'REST APIs', 'Entity Framework', 'Python'],
      'AI / ML': ['Ollama', 'LLM Integration', 'AI Pipelines', 'Computer Vision'],
      'Cloud & DB': ['SQL Server', 'Supabase', 'SQLite', 'Azure', 'Serverless'],
      'Tools': ['Visual Studio', 'VS Code', 'Git', 'Postman', 'Agile / Scrum'],
      'Other': ['HIPAA', 'HL7', 'Real-time Chat', 'BLE', 'Cross-platform'],
    };

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Skills & Technologies',
            subtitle: 'Core competencies and technical expertise',
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skills.entries.map((entry) {
              return SizedBox(
                width: isMobile
                    ? double.infinity
                    : Responsive.isTablet(context)
                        ? (MediaQuery.of(context).size.width - 192) / 2
                        : (Responsive.contentWidth(context) - 32) / 3,
                child: _SkillCategory(
                  title: entry.key,
                  skills: entry.value,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _SkillCategory extends StatelessWidget {
  final String title;
  final List<String> skills;

  const _SkillCategory({required this.title, required this.skills});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: skills.map((s) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  s,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final featured = ProjectData.featuredProjects;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Featured Projects',
            subtitle: 'AI, Computer Vision, Real-time Communication & Enterprise Healthcare',
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossCount = Responsive.projectGridCrossAxisCount(context);
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: featured.map((project) {
                  final width = crossCount == 1
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 16 * (crossCount - 1)) / crossCount;
                  return SizedBox(
                    width: width,
                    child: ProjectCard(
                      project: project,
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/projects/${project.id}',
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/projects'),
              icon: const Text('View All Projects'),
              label: const Icon(Icons.arrow_forward_rounded, size: 16),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _TechnologyShowcaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    final techCounts = ProjectData.technologyProjectCount;
    const groups = ProjectData.technologyGroups;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Technology Showcase',
            subtitle: 'Technologies grouped by category with project usage count',
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: groups.entries.map((entry) {
              return SizedBox(
                width: isMobile
                    ? double.infinity
                    : Responsive.isTablet(context)
                        ? (MediaQuery.of(context).size.width - 192) / 2
                        : (Responsive.contentWidth(context) - 64) / 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...entry.value.map((tech) {
                        final count = techCounts[tech] ?? 0;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  tech,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                              if (count > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '$count project${count > 1 ? 's' : ''}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _DownloadSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 40,
      ),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.secondary.withValues(alpha: 0.08),
            theme.colorScheme.secondary.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.picture_as_pdf_rounded,
            size: 40,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Download Portfolio PDF',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Get the complete portfolio document with all project details',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              launchUrl(Uri.parse('assets/assets/Harsh_Portfolio.pdf'));
            },
            icon: const Icon(Icons.download_rounded, size: 18),
            label: const Text('Download PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
