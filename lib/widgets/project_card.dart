import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String timeRange;
  final String title;
  final String description;
  final String? imageUrl;
  final String? liveUrl;
  final String? githubUrl;
  
  const ProjectCard({
    super.key,
    required this.timeRange,
    required this.title,
    required this.description,
    this.imageUrl,
    this.liveUrl,
    this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeRange,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    _buildTryItOutButton(),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _ProjectImageHover(),
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeRange,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      _buildTryItOutButton(),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                SizedBox(
                  width: 360,
                  height: 203,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _ProjectImageHover(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTryItOutButton() {
    return Row(
      children: [
        if (liveUrl != null)
          ElevatedButton.icon(
            onPressed: () async {
              final uri = Uri.parse(liveUrl!);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            icon: const Icon(Icons.open_in_new, size: 18),
            label: const Text('Try it out'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        if (liveUrl != null) const SizedBox(width: 12),
        _buildGithubButton(),
      ],
    );
  }

  Widget _buildGithubButton() {
    return OutlinedButton.icon(
      onPressed: githubUrl != null
          ? () async {
              final uri = Uri.parse(githubUrl!);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            }
          : null,
      icon: const Icon(Icons.code, size: 18),
      label: const Text('GitHub'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class _ProjectImageHover extends StatefulWidget {
  @override
  State<_ProjectImageHover> createState() => _ProjectImageHoverState();
}

class _ProjectImageHoverState extends State<_ProjectImageHover> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // Get access to the ProjectCard's imageUrl
    final ProjectCard projectCard = context.findAncestorWidgetOfExactType<ProjectCard>()!;
    final String imageUrl = projectCard.imageUrl ?? 'assets/images/placeholder.png';
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.12 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: imageUrl.startsWith('http')
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
              )
            : Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
              ),
      ),
    );
  }
  
  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(
          Icons.image,
          size: 48,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}