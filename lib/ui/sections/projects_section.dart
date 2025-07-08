import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/project_card.dart';
import '../sections/experience_section.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: CupertinoSlidingSegmentedControl<int>(
              groupValue: _selectedIndex,
              onValueChanged: (int? value) {
                if (value != null) {
                  setState(() => _selectedIndex = value);
                }
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              thumbColor: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.all(4),
              children: {
                0: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Projects',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _selectedIndex == 0
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                1: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Experience',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _selectedIndex == 1
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              },
            ),
          ),
        ),
        if (_selectedIndex == 0) _buildProjectsList(),
        if (_selectedIndex == 1) _buildExperienceList(),
        const SizedBox(height: 24),
        _buildViewAllButton(),
        const SizedBox(height: 64),
      ],
    );
  }

  Widget _buildProjectsList() {
    return Column(
      children: [
        ProjectCard(
          timeRange: 'May 2025',
          title: 'Ryder - Car Rental made easy',
          description: "Skip the boring paperwork! 🚗 Book any car in under 60 seconds with just your phone. Features sleek glassmorphic UI because why settle for ordinary?",
          imageUrl: 'assets/images/ryder.png',
          liveUrl: 'https://nikkhilpareek.github.io/ryder/',
          githubUrl: 'https://github.com/nikkhilpareek/ryder',
          skills: ['Flutter', 'Dart', 'Firebase', 'OpenStreetMap API', 'Glass UI'],
        ),
        ProjectCard(
          timeRange: 'July 2025',
          title: 'Fylez - Blockchain based Cloud Storage',
            description: 'Your files, but make it blockchain! 🔗 Secure, private, and tamper-proof cloud storage that actually respects your privacy.',
          imageUrl: 'assets/images/fylez-proj.png',
          liveUrl: 'https://cryptotrack.example.com',
          githubUrl: 'https://github.com/nikkhilpareek/fylez',
          skills: ['Flutter', 'Node.js', 'Blockchain', 'Dart', 'Pinata API',]
        ),
        ProjectCard(
          timeRange: 'July 2025',
          title: 'Habits - A Minimal Habit Tracker',
          description: 'Build better habits without the overwhelm! ✨ Clean, minimal design that focuses on what matters - consistency over complexity.',
          imageUrl: 'assets/images/habits.png',
          // liveUrl: 'https://ecoscan.example.com',
          githubUrl: 'https://github.com/nikkhilpareek/habit',
          skills: ['Flutter', 'Dart', 'Bloc', 'Material Design'],
        ),
        ProjectCard(
          timeRange: 'July 2025',
          title: 'Auth - Minimal Authentication Screens',
          description: 'Because every app needs auth screens! 🔐 Built this minimal, reusable set so you (and I) never have to start from scratch again.',
          imageUrl: 'assets/images/auth.png',
          liveUrl: 'https://nikkhilpareek.github.io/Minimal-Auth-Screens-in-Flutter/',
          githubUrl: 'https://github.com/nikkhilpareek/Minimal-Auth-Screens-in-Flutter',
          skills: ['Flutter', 'Dart', 'Lottie', 'Minimal Design'],
        ),
      ],
    );
  }

  Widget _buildExperienceList() {
    return const ExperienceSection();
  }

  Widget _buildViewAllButton() {
    // Only show button for Projects tab, not for Experience tab
    if (_selectedIndex != 0) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 200), // Limit max width
        child: InkWell(
          onTap: () async {
            final uri = Uri.parse('https://github.com/nikkhilpareek');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Make row take minimum space
              children: [
                const Text(
                  'View all projects',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 4),
                Transform.translate(
                  offset: const Offset(0, -2),
                  child: const Text(
                    '→',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
