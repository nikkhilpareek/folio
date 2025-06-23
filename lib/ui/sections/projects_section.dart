import 'package:flutter/material.dart';
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
  final List<String> _tabs = ['Projects', 'Experience'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.background
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected
                          ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))]
                          : [],
                    ),
                    child: Text(
                      _tabs[index],
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? Theme.of(context).colorScheme.onBackground
                            : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                );
              }),
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
          description: "Skip the queues, skip the paperwork. Ryder lets you book any self-drive car in under 60 seconds with just your phone. From interactive maps to instant booking, we've reimagined car rental with a sleek glassmorphic dark UI that makes finding your perfect ride effortless.",
          imageUrl: 'assets/images/ryder.png',
          liveUrl: 'https://nikkhilpareek.github.io/ryder/',
          githubUrl: 'https://github.com/nikkhilpareek/ryder',
        ),
        ProjectCard(
          timeRange: '2018 - present',
          title: 'CryptoTrack - Blockchain Portfolio',
          description: 'A comprehensive cryptocurrency tracking platform that allows users to monitor market movements, manage their portfolio, and analyze performance with interactive visualizations and real-time data.',
          imageUrl: 'assets/images/crypto.png',
          liveUrl: 'https://cryptotrack.example.com',
          githubUrl: 'https://github.com/nikhilpareek/cryptotrack',
        ),
        ProjectCard(
          timeRange: '2016 - present',
          title: 'EcoScan - Sustainable Shopping',
          description: 'An app that helps consumers make environmentally conscious decisions by scanning product barcodes and providing sustainability ratings, ethical production information, and eco-friendly alternatives.',
          imageUrl: 'assets/images/ecoscan.png',
          liveUrl: 'https://ecoscan.example.com',
          githubUrl: 'https://github.com/nikhilpareek/ecoscan',
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
