import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/project_data.dart';
import '../models/project_model.dart';
import '../utils/responsive.dart';
import '../widgets/nav_bar.dart';
import '../widgets/project_card.dart';
import '../widgets/section_title.dart';
import '../widgets/footer.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  String _searchQuery = '';
  String? _selectedDomain;
  String? _selectedTech;

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

  List<ProjectModel> get _filteredProjects {
    var results = ProjectData.projects.toList();

    if (_searchQuery.isNotEmpty) {
      results = ProjectData.search(_searchQuery);
    }
    if (_selectedDomain != null) {
      results = results.where((p) => p.domain == _selectedDomain).toList();
    }
    if (_selectedTech != null) {
      results =
          results.where((p) => p.techStack.contains(_selectedTech)).toList();
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 80,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Project Portfolio',
                        subtitle:
                            'A curated collection of production applications spanning healthcare, AI, hospitality, logistics, and finance',
                      ),
                      const SizedBox(height: 32),
                      _buildSearchBar(theme),
                      const SizedBox(height: 16),
                      _buildDomainFilters(theme),
                      const SizedBox(height: 12),
                      _buildTechFilters(theme),
                      const SizedBox(height: 32),
                      _buildResults(theme),
                    ],
                  ),
                ),
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

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.2),
        ),
      ),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search projects by name, domain, or technology...',
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDomainFilters(ThemeData theme) {
    final domains = ProjectData.allDomains;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'All Domains',
            isSelected: _selectedDomain == null,
            onTap: () => setState(() => _selectedDomain = null),
          ),
          const SizedBox(width: 8),
          ...domains.map((domain) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _FilterChip(
                  label: domain,
                  isSelected: _selectedDomain == domain,
                  onTap: () => setState(() {
                    _selectedDomain =
                        _selectedDomain == domain ? null : domain;
                  }),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTechFilters(ThemeData theme) {
    final techs = ['Flutter', 'Xamarin.Forms', '.NET MAUI', 'Supabase', 'AI', 'Python', 'C#'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'All Tech',
            isSelected: _selectedTech == null,
            onTap: () => setState(() => _selectedTech = null),
          ),
          const SizedBox(width: 8),
          ...techs.map((tech) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _FilterChip(
                  label: tech,
                  isSelected: _selectedTech == tech,
                  onTap: () => setState(() {
                    _selectedTech = _selectedTech == tech ? null : tech;
                  }),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildResults(ThemeData theme) {
    final projects = _filteredProjects;

    if (projects.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 48,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              Text(
                'No projects found',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = Responsive.projectGridCrossAxisCount(context);
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: projects.asMap().entries.map((entry) {
            final width = crossCount == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - 16 * (crossCount - 1)) / crossCount;
            return SizedBox(
              width: width,
              child: ProjectCard(
                project: entry.value,
                onTap: () => Navigator.pushNamed(
                  context,
                  '/projects/${entry.value.id}',
                ),
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: (100 * entry.key).ms,
                  ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? theme.colorScheme.secondary.withValues(alpha: 0.15)
                : _hovering
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.05)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isSelected
                  ? theme.colorScheme.secondary.withValues(alpha: 0.5)
                  : theme.dividerColor.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
              color: widget.isSelected
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}
