import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({super.key});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  bool _showAll = false;

  // All certificates data
  final List<Map<String, dynamic>> _allCertificates = [
    {
      'dateRange': 'June 2025',
      'title': 'Flutter & Dart - Complete App Development Course',
      'description': 'Comprehensive course covering Flutter framework, Dart programming, mobile app development, state management, and best practices for building cross-platform applications.',
      'issuer': 'Packt',
      'imageUrl': 'assets/images/packt.png',
      'verifyUrl': 'https://coursera.org/verify/specialization/UJOZIKWGJTGD',
      'skills': ['Flutter', 'Dart', 'Mobile Development', 'Cross-platform'],
    },
    {
      'dateRange': 'July 2025',
      'title': 'Designing User Interfaces and Experiences (UI/UX)',
      'description': 'Comprehensive course on user interface design, user experience principles, design thinking, prototyping, and creating intuitive digital experiences authorized by IBM.',
      'issuer': 'IBM',
      'imageUrl': 'assets/images/uiuxibm.png',
      'verifyUrl': 'https://coursera.org/verify/T3GZLQOFDY0X',
      'skills': ['UI/UX Design', 'Design Thinking', 'Prototyping', 'User Research'],
    },
    {
      'dateRange': 'July 2025',
      'title': 'Flutter and Dart: Developing iOS, Android, and Mobile Apps',
      'description': 'Advanced course covering Flutter framework and Dart programming for developing cross-platform mobile applications for iOS, Android, and mobile platforms authorized by IBM.',
      'issuer': 'IBM',
      'imageUrl': 'assets/images/flutteranddartibm.png',
      'verifyUrl': 'https://coursera.org/verify/YA3D6C3084GG',
      'skills': ['Flutter', 'Dart', 'iOS Development', 'Android Development', 'Mobile Apps'],
    },
    {
      'dateRange': 'September 2024',
      'title': 'Blockchain Specialization',
      'description': 'Comprehensive 4-course specialization covering blockchain fundamentals, smart contracts, decentralized applications, and blockchain platforms from University at Buffalo.',
      'issuer': 'University at Buffalo',
      'imageUrl': 'assets/images/blockchainspecialisation.png',
      'verifyUrl': 'https://coursera.org/verify/specialization/KTQRADW50TUD',
      'skills': ['Blockchain', 'Smart Contracts', 'Decentralized Apps', 'Cryptocurrency', 'Web3'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final certificatesToShow = _showAll ? _allCertificates : _allCertificates.take(3).toList();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Certifications',
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          
          // Certification cards
          ...certificatesToShow.map((cert) => _CertificationCard(
            dateRange: cert['dateRange'],
            title: cert['title'],
            description: cert['description'],
            issuer: cert['issuer'],
            imageUrl: cert['imageUrl'],
            verifyUrl: cert['verifyUrl'],
            skills: List<String>.from(cert['skills']),
          )),
          
          // View All / View Less button
          if (_allCertificates.length > 3)
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 10.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250), // Limit max width
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _showAll = !_showAll;
                    });
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Make row take minimum space
                      children: [
                        Text(
                          _showAll ? 'View less certifications' : 'View all certifications',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Transform.translate(
                          offset: const Offset(0, -2),
                          child: Text(
                            _showAll ? '↑' : '→',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CertificationCard extends StatefulWidget {
  final String dateRange;
  final String title;
  final String description;
  final String issuer;
  final String imageUrl;
  final String verifyUrl;
  final List<String>? skills;
  
  const _CertificationCard({
    required this.dateRange,
    required this.title,
    required this.description,
    required this.issuer,
    required this.imageUrl,
    required this.verifyUrl,
    this.skills,
  });

  @override
  State<_CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<_CertificationCard> {
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
                      widget.dateRange,
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
                    _buildVerifyButton(),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _CertificationImageHover(),
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
                        widget.dateRange,
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
                      _buildVerifyButton(),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                SizedBox(
                  width: 360,
                  height: 203,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _CertificationImageHover(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildVerifyButton() {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final uri = Uri.parse(widget.verifyUrl);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          icon: const Icon(Icons.verified, size: 18),
          label: const Text('Verify Certificate'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 12),
        _buildIssuerChip(),
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

  Widget _buildIssuerChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade600.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.green.shade400.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.school,
            size: 16,
            color: Colors.green.shade400,
          ),
          const SizedBox(width: 6),
          Text(
            widget.issuer,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.green.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

class _CertificationImageHover extends StatefulWidget {
  @override
  State<_CertificationImageHover> createState() => _CertificationImageHoverState();
}

class _CertificationImageHoverState extends State<_CertificationImageHover> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // Get access to the CertificationCard's imageUrl and verifyUrl
    final _CertificationCardState certCardState = context.findAncestorStateOfType<_CertificationCardState>()!;
    final String imageUrl = certCardState.widget.imageUrl;
    final String verifyUrl = certCardState.widget.verifyUrl;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Stack(
        children: [
          // Certificate image with hover scale
          AnimatedScale(
            scale: _hovering ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
            ),
          ),
          // Hover overlay
          if (_hovering)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: 1.0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      final uri = Uri.parse(verifyUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Verify Certificate',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
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
