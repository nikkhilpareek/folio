import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Education',
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          
          // Education cards
          _EducationCard(
            logo: 'assets/images/jkluu.png',
            degree: 'Bachelor of Technology (B.Tech)',
            field: 'Computer Science & Engineering',
            institution: 'JK Lakshmipat University',
            location: 'Jaipur, Rajasthan, India',
            duration: '2022 - 2026',
            gpa: '8.1 CGPA',
            highlights: [
              'Relevant Coursework: Data Structures and Algorithms, Database Management Systems, Software Engineering, Mobile App Development',
              'Coordinated in Various Clubs (Astronomy, Drama, Quiz, Tech)',
              'Participated in multiple hackathons and coding competitions',
            ],
          ),
          
          _EducationCard(
            logo: 'assets/images/school.png',
            degree: 'Senior Secondary (XII)',
            field: 'Science Stream (PCM)',
            institution: 'R.V.N. Sr. Sec. School',
            location: 'Gharsana, Rajasthan, India',
            duration: '2021',
            gpa: '97.8%',
          ),

          _EducationCard(
            logo: 'assets/images/school.png',
            degree: 'Secondary (X)',
            field: 'Science Stream (PCM)',
            institution: 'R.V.N. Sr. Sec. School',
            location: 'Gharsana, Rajasthan, India',
            duration: '2019',
            gpa: '89.33%',
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatefulWidget {
  final String logo;
  final String degree;
  final String field;
  final String institution;
  final String location;
  final String duration;
  final String gpa;
  final List<String>? highlights;
  
  const _EducationCard({
    required this.logo,
    required this.degree,
    required this.field,
    required this.institution,
    required this.location,
    required this.duration,
    required this.gpa,
    this.highlights,
  });

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> with SingleTickerProviderStateMixin {
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
    final contentSpacing = isMobile ? 16.0 : 32.0;

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 24 : 32),
      child: Column(
        children: [
          InkWell(
            onTap: widget.highlights != null && widget.highlights!.isNotEmpty ? _toggleExpand : null,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mobile layout: Logo and content in column
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              widget.logo,
                              width: logoSize,
                              height: logoSize,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.school,
                                size: logoSize * 0.5,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and expand icon
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.degree,
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      if (widget.highlights != null && widget.highlights!.isNotEmpty)
                                        AnimatedBuilder(
                                          animation: _iconRotation,
                                          builder: (context, child) {
                                            return Transform.rotate(
                                              angle: _iconRotation.value * 3.14159,
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 18,
                                                color: theme.textTheme.bodySmall?.color,
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.field,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.blue.shade300,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.institution,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      height: 1.2,
                                    ),
                                  ),
                                  Text(
                                    widget.location,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                                      fontSize: 11,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // Duration and GPA chips in a row
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade600.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Colors.blue.shade400.withOpacity(0.3),
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Text(
                                          widget.duration,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue.shade400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade600.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Colors.green.shade400.withOpacity(0.3),
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Text(
                                          widget.gpa,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green.shade400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Desktop layout: Logo on left
                        Image.asset(
                          widget.logo,
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.school,
                            size: logoSize * 0.5,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                        SizedBox(width: contentSpacing),
                        // Main content
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.degree,
                                      style: theme.textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.field,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.blue.shade300,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.institution,
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    Text(
                                      widget.location,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Duration and GPA on the right
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade600.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.blue.shade400.withOpacity(0.3),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Text(
                                      widget.duration,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue.shade400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade600.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.green.shade400.withOpacity(0.3),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Text(
                                      widget.gpa,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green.shade400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Arrow icon (always reserve space for alignment)
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: widget.highlights != null && widget.highlights!.isNotEmpty
                                      ? AnimatedBuilder(
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
                                        )
                                      : const SizedBox(), // Empty space to maintain alignment
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          // Expandable highlights section
          if (widget.highlights != null && widget.highlights!.isNotEmpty)
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
                        'Academic Highlights',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade300,
                          fontSize: isMobile ? 12 : null,
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      ...(widget.highlights?.map((highlight) => Padding(
                        padding: EdgeInsets.only(bottom: isMobile ? 6 : 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: isMobile ? 4 : 6, 
                                right: isMobile ? 8 : 12,
                              ),
                              width: isMobile ? 3 : 4,
                              height: isMobile ? 3 : 4,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                highlight,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  height: 1.3,
                                  fontSize: isMobile ? 11 : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList() ?? []),
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
