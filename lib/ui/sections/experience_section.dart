import 'dart:ui';

import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = [
      _ExperienceCard(
        logo: 'assets/images/dynamicore.jpeg',
        title: 'Flutter Developer Intern',
        company: 'Dynamicore Strategies Private Limited',
        type: 'Internship',
        date: 'May 2025 - Present · 2 mos',
        location: 'Jaipur, Rajasthan, India · Hybrid',
      ),
      _ExperienceCard(
        logo: 'assets/images/jklu.jpg',
        title: 'Teaching Assistant',
        company: 'JK Lakshmipat University, Jaipur',
        type: 'Full-time',
        date: 'Aug 2024 - Dec 2024 · 5 mos',
        location: 'Jaipur · On-site',
      ),
      _ExperienceCard(
        logo: 'assets/images/aunwesha.png',
        title: 'Data Analyst Intern',
        company: 'Aunwesha Knowledge Technologies Private Limited',
        type: 'Internship',
        date: 'May 2024 - Jun 2024 · 2 mos',
        location: 'Kolkata, West Bengal, India · Hybrid',
      ),
      _ExperienceCard(
        logo: 'assets/images/jklu.jpg',
        title: 'Social Media Photography Intern',
        company: 'JK Lakshmipat University, Jaipur',
        type: 'Internship',
        date: 'Apr 2024 - May 2024 · 2 mos',
        location: 'Jaipur, Rajasthan, India · On-site',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...experiences,
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final String logo;
  final String title;
  final String company;
  final String type;
  final String date;
  final String location;
  const _ExperienceCard({
    required this.logo,
    required this.title,
    required this.company,
    required this.type,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo on the left
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surface.withOpacity(0.7),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.08),
                width: 1.2,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              logo,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.business, size: 32),
            ),
          ),
          const SizedBox(width: 32),
          // Main content and date
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$company · $type',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        location,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                // Date on the right
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                  child: Text(
                    date,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.85),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
