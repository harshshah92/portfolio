import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../widgets/section_title.dart';
import '../widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

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
            title: 'Get In Touch',
            subtitle: 'Have a project in mind? Let\'s discuss.',
          ),
          const SizedBox(height: 12),
          Text(
            'Feel free to reach out for collaborations, project inquiries, or just to say hello. '
            'I\'ll get back to you as soon as possible.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 560,
            ),
            child: const ContactForm(),
          ),
        ],
      ),
    );
  }
}
