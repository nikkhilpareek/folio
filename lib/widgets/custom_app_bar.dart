import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onThemeToggle;
  const CustomAppBar({super.key, this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 768;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nikhil Pareek',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            isMobile
                ? Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildIconBtn(
                        icon: FontAwesomeIcons.github,
                        url: 'https://github.com/nikkhilpareek',
                        tooltip: 'GitHub',
                      ),
                      _buildIconBtn(
                        icon: FontAwesomeIcons.linkedin,
                        url: 'https://www.linkedin.com/in/nikkhil-pareek/',
                        tooltip: 'LinkedIn',
                      ),
                      _buildIconBtn(
                        icon: FontAwesomeIcons.envelope,
                        url: 'mailto:nikhilpareekpandit@gmail.com',
                        tooltip: 'Email',
                      ),
                      _buildIconBtn(
                        icon: FontAwesomeIcons.instagram,
                        url: 'https://instagram.com/nikkhil.pareek',
                        tooltip: 'Instagram',
                      ),
                      _buildThemeToggleBtn(context),
                    ],
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
                      const SizedBox(width: 16),
                      _buildThemeToggleBtn(context),
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
  }) {
    return IconButton(
      icon: FaIcon(icon, size: 20),
      tooltip: tooltip,
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }

  Widget _buildThemeToggleBtn(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.brightness_6, size: 22),
      tooltip: 'Toggle Theme',
      onPressed: onThemeToggle ?? () {},
    );
  }
}