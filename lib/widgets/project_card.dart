import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String timeRange;
  final String title;
  final String description;
  final String? imageUrl;
  final String? liveUrl;
  final String? githubUrl;
  final String? figmaUrl;
  final List<String>? skills;
  
  const ProjectCard({
    super.key,
    required this.timeRange,
    required this.title,
    required this.description,
    this.imageUrl,
    this.liveUrl,
    this.githubUrl,
    this.figmaUrl,
    this.skills,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image first on mobile
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _ProjectImageHover(),
                  ),
                ),
                const SizedBox(height: 20),
                // Text content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.timeRange,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    _buildTryItOutButton(),
                  ],
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
                        widget.timeRange,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      if (widget.skills != null && widget.skills!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _buildSkillsRow(),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        widget.description,
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
        if (widget.liveUrl != null)
          ElevatedButton.icon(
            onPressed: () async {
              final uri = Uri.parse(widget.liveUrl!);
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
        if (widget.liveUrl != null) const SizedBox(width: 12),
        _buildGithubButton(),
        if (widget.figmaUrl != null) const SizedBox(width: 12),
        if (widget.figmaUrl != null) _buildFigmaButton(),
      ],
    );
  }

  Widget _buildSkillsRow() {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: widget.skills!.map((skill) => _buildSkillDot(skill)).toList(),
    );
  }

  Widget _buildSkillDot(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.blue.shade600.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade400.withOpacity(0.4),
          width: 0.5,
        ),
      ),
      child: Text(
        skill,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.blue.shade400,
        ),
      ),
    );
  }

  Widget _buildGithubButton() {
    return OutlinedButton.icon(
      onPressed: widget.githubUrl != null
          ? () async {
              final uri = Uri.parse(widget.githubUrl!);
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

  Widget _buildFigmaButton() {
    return OutlinedButton(
      onPressed: widget.figmaUrl != null
          ? () async {
              final uri = Uri.parse(widget.figmaUrl!);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            }
          : null,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(fontSize: 14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/figma.png',
            width: 18,
            height: 18,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.design_services,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          const Text('Design'),
        ],
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
    final _ProjectCardState projectCardState = context.findAncestorStateOfType<_ProjectCardState>()!;
    final String imageUrl = projectCardState.widget.imageUrl ?? 'assets/images/placeholder.png';
    
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