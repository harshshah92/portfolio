import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovering = false;

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
      default:
        return Icons.code_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final domainColor = _domainColor(widget.project.domain);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0.0, _hovering ? -4.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering
                  ? domainColor.withValues(alpha: 0.5)
                  : theme.dividerColor.withValues(alpha: 0.2),
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: domainColor.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: domainColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _domainIcon(widget.project.domain),
                      color: domainColor,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  if (widget.project.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
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
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFF59E0B),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.project.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.project.subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: domainColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.project.domain,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: domainColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.project.techStack.take(4).map((tech) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tech,
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
