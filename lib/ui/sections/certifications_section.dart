import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final certifications = [
      _CertificationCard(
        title: 'Flutter & Dart - Complete App Development Course',
        issuer: 'Packt',
        image: 'assets/images/packt.png',
        link: 'https://coursera.org/verify/specialization/UJOZIKWGJTGD',
        delay: const Duration(milliseconds: 0),
      ),
      _CertificationCard(
        title: 'C++ Programming',
        issuer: 'Coursera',
        image: 'assets/images/cert_cpp.png',
        link: 'https://example.com/cpp-cert',
        delay: const Duration(milliseconds: 100),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Certifications', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              children: certifications.map((card) => card).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _CertificationCard extends StatefulWidget {
  final String title;
  final String issuer;
  final String image;
  final String link;
  final Duration delay;
  const _CertificationCard({required this.title, required this.issuer, required this.image, required this.link, required this.delay});

  @override
  State<_CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<_CertificationCard> {
  double _opacity = 0;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    Timer(widget.delay, () {
      if (mounted) setState(() => _opacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_hovering ? 0.18 : 0.10),
                blurRadius: _hovering ? 32 : 16,
                offset: const Offset(0, 8),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.surface.withOpacity(0.7),
                theme.colorScheme.surface.withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top padding for visual appeal
                  const SizedBox(height: 16),
                  
                  // Certificate Image with Hover Effect
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  widget.image,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image, size: 40),
                                  ),
                                ),
                              ),
                              if (_hovering)
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: 1.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Material(
                                      color: Colors.black.withOpacity(0.55),
                                      child: InkWell(
                                        onTap: () async {
                                          final uri = Uri.parse(widget.link);
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                                          }
                                        },
                                        child: SizedBox(
                                          width: constraints.maxWidth,
                                          height: constraints.maxHeight,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.verified, color: Colors.white, size: 22),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Verify Certificate',
                                                  style: theme.textTheme.titleMedium?.copyWith(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 1.1,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // Certificate Details
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.2,
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.school, color: Colors.grey[400], size: 16),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                widget.issuer,
                                style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w400,
                                    ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
