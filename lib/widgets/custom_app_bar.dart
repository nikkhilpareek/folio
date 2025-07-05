import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 768;
        final bool isVerySmall = constraints.maxWidth < 400;
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Nikhil Pareek',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isVerySmall ? 20 : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            isMobile
                ? Flexible(
                    child: Wrap(
                      spacing: isVerySmall ? 2 : 4,
                      runSpacing: 4,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _buildIconBtn(
                          icon: FontAwesomeIcons.github,
                          url: 'https://github.com/nikkhilpareek',
                          tooltip: 'GitHub',
                          size: isVerySmall ? 16 : 18,
                        ),
                        _buildIconBtn(
                          icon: FontAwesomeIcons.linkedin,
                          url: 'https://www.linkedin.com/in/nikkhil-pareek/',
                          tooltip: 'LinkedIn',
                          size: isVerySmall ? 16 : 18,
                        ),
                        _buildIconBtn(
                          icon: FontAwesomeIcons.envelope,
                          url: 'mailto:nikhilpareekpandit@gmail.com',
                          tooltip: 'Email',
                          size: isVerySmall ? 16 : 18,
                        ),
                        _buildIconBtn(
                          icon: FontAwesomeIcons.instagram,
                          url: 'https://instagram.com/nikkhil.pareek',
                          tooltip: 'Instagram',
                          size: isVerySmall ? 16 : 18,
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      _buildIconBtn(
                        icon: FontAwesomeIcons.github,
                        url: 'https://github.com/nikkhilpareek',
                        tooltip: 'GitHub',
                      ),
                      const SizedBox(width: 16),
                      _buildIconBtn(
                        icon: FontAwesomeIcons.linkedin,
                        url: 'https://www.linkedin.com/in/nikkhil-pareek/',
                        tooltip: 'LinkedIn',
                      ),
                      const SizedBox(width: 16),
                      _buildIconBtn(
                        icon: FontAwesomeIcons.envelope,
                        url: 'mailto:nikhilpareekpandit@gmail.com',
                        tooltip: 'Email',
                      ),
                      const SizedBox(width: 16),
                      _buildIconBtn(
                        icon: FontAwesomeIcons.instagram,
                        url: 'https://instagram.com/nikkhil.pareek',
                        tooltip: 'Instagram',
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }

  Widget _buildIconBtn({
    required IconData icon,
    required String url,
    required String tooltip,
    double? size,
  }) {
    final iconSize = size ?? 20;
    return IconButton(
      icon: FaIcon(icon, size: iconSize),
      tooltip: tooltip,
      constraints: iconSize < 18 
          ? const BoxConstraints(minWidth: 32, minHeight: 32) 
          : const BoxConstraints(minWidth: 36, minHeight: 36),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}