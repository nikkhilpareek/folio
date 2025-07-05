import 'dart:ui';

import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final experiences = [
      _ExperienceCard(
        logo: 'assets/images/dynamicore.jpeg',
        title: 'Flutter Developer Intern',
        company: 'Dynamicore Strategies Private Limited',
        type: 'Internship',
        date: 'May 2025 - Present · 2 mos',
        location: 'Jaipur, Rajasthan, India · Hybrid',
        workDetails: [
          'Designed and Developed fintech mobile app with various features including financial education system and virtual trading simulator',
          'Implemented cross-platform Flutter app with 15+ screens including portfolio management and loan calculators',
          'Presented gamified financial learning platform with XP points and achievement tracking system',
          'Implemented AI chat bot for analysing investment portfolio'
        ],
      ),
      _ExperienceCard(
        logo: 'assets/images/jklu.jpg',
        title: 'Teaching Assistant',
        company: 'JK Lakshmipat University, Jaipur',
        type: 'Full-time',
        date: 'Aug 2024 - Dec 2024 · 5 mos',
        location: 'Jaipur · On-site',
        workDetails: [
          'Assisted professor in teaching Statistics and Data Visulaisation using Python Programming',
          'Mentored 60+ students in coding assignments and project development',
          'Conducted lab sessions and helped students debug complex programming issues',
          'Organized Mock project building session on data visualisation',
        ],
      ),
      _ExperienceCard(
        logo: 'assets/images/aunwesha.png',
        title: 'Data Analyst Intern',
        company: 'Aunwesha Knowledge Technologies Private Limited',
        type: 'Internship',
        date: 'May 2024 - Jun 2024 · 2 mos',
        location: 'Kolkata, West Bengal, India · Hybrid',
        workDetails: [
          'Analyzed large datasets using Python, Pandas, and NumPy for business insights',
          'Created interactive dashboards using Tableau for stakeholders',
          'Performed statistical analysis and data visualization to identify trends',
          'Developed a Java based Web App for data visualisation',
          'Integrated Vega-lite for Improved data visualisation',
        ],
      ),
      _ExperienceCard(
        logo: 'assets/images/jklu.jpg',
        title: 'Social Media Photography Intern',
        company: 'JK Lakshmipat University, Jaipur',
        type: 'Internship',
        date: 'Apr 2024 - May 2024 · 2 mos',
        location: 'Jaipur, Rajasthan, India · On-site',
        workDetails: [
          'Captured high-quality photos for university campus',
          'Coordinated with marketing team to create required visual content',
          'Created visual content for university website and promotional materials',
        ],
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

class _ExperienceCard extends StatefulWidget {
  final String logo;
  final String title;
  final String company;
  final String type;
  final String date;
  final String location;
  final List<String> workDetails;
  
  const _ExperienceCard({
    required this.logo,
    required this.title,
    required this.company,
    required this.type,
    required this.date,
    required this.location,
    required this.workDetails,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _iconRotation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 700;
    final logoSize = isMobile ? 48.0 : 64.0;
    final borderRadius = isMobile ? 12.0 : 16.0;
    final contentSpacing = isMobile ? 16.0 : 32.0;
    final bottomPadding = isMobile ? 32.0 : 40.0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpand,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: logoSize,
                              height: logoSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(borderRadius),
                                color: theme.colorScheme.surface.withOpacity(0.7),
                                border: Border.all(
                                  color: theme.dividerColor.withOpacity(0.08),
                                  width: 1.2,
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.asset(
                                widget.logo,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.business, size: logoSize * 0.5),
                              ),
                            ),
                            SizedBox(width: contentSpacing),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.title, style: theme.textTheme.titleMedium),
                                  SizedBox(height: 4),
                                  Text('${widget.company} · ${widget.type}', style: theme.textTheme.bodySmall),
                                ],
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _iconRotation,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _iconRotation.value * 3.14159,
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(widget.location, style: theme.textTheme.bodySmall),
                        SizedBox(height: 4),
                        Text(widget.date, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo on the left
                        Container(
                          width: logoSize,
                          height: logoSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: theme.colorScheme.surface.withOpacity(0.7),
                            border: Border.all(
                              color: theme.dividerColor.withOpacity(0.08),
                              width: 1.2,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            widget.logo,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.business, size: logoSize * 0.5),
                          ),
                        ),
                        SizedBox(width: contentSpacing),
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
                                      widget.title,
                                      style: theme.textTheme.displaySmall,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${widget.company} · ${widget.type}',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      widget.location,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              // Date on the right
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                                child: Text(
                                  widget.date,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.85),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              // Arrow icon
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: AnimatedBuilder(
                                  animation: _iconRotation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _iconRotation.value * 3.14159,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 24,
                                        color: theme.textTheme.bodySmall?.color,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          // Expandable work details section
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: isMobile ? 0 : logoSize + contentSpacing,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Responsibilities & Achievements',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade300,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.workDetails.map((detail) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 12),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              detail,
                              style: theme.textTheme.bodySmall?.copyWith(
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
