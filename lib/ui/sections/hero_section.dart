import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text content
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to My Portfolio",
                      style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: isMobile ? double.infinity : 400,
                      child: Text(
                        "I'm a Computer Science undergrad passionate about building clean, functional mobile apps using Flutter. Currently exploring the world of app development, I'm gaining hands-on experience through internships, projects, and constant learning.",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildResumeButton(),
                  ],
                ),
              ),
              const SizedBox(width: 48, height: 48),
              // Image
              Expanded(
                flex: 1,
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/hero.jpg',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResumeButton() {
    return _ResumeHoverButton();
  }

}

class _ResumeHoverButton extends StatefulWidget {
  @override
  State<_ResumeHoverButton> createState() => _ResumeHoverButtonState();
}

class _ResumeHoverButtonState extends State<_ResumeHoverButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: ElevatedButton.icon(
          onPressed: () {
            // Download resume logic
          },
          icon: const Icon(Icons.download, size: 18),
          label: const Text('Download resume'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
