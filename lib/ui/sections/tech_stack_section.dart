import 'package:flutter/material.dart';
import 'dart:async';

class TechStackSection extends StatefulWidget {
  const TechStackSection({super.key});

  @override
  State<TechStackSection> createState() => _TechStackSectionState();
}

class _TechStackSectionState extends State<TechStackSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final techs = [
      // Mobile Development
      _TechStackItem('Flutter', 'assets/images/flutter.png'),
      _TechStackItem('Dart', 'assets/images/dart.png'),
      _TechStackItem('Kotlin', 'assets/images/kotlin.png'),
      // Programming Languages
      _TechStackItem('C++', 'assets/images/cpp.png'),
      _TechStackItem('Solidity', 'assets/images/solidity.png'),
      // Backend & APIs
      _TechStackItem('NodeJS', 'assets/images/nodejs.png'),
      _TechStackItem('FastAPI', 'assets/images/fapi.png'),
      _TechStackItem('Rest API', 'assets/images/restapi.png'),
      // Databases
      _TechStackItem('Firebase', 'assets/images/firebase.png'),
      _TechStackItem('PostgreSQL', 'assets/images/postgresql.png'),
      _TechStackItem('SQL', 'assets/images/sql.png'),
      // Development Tools
      _TechStackItem('VS Code', 'assets/images/vsc.png'),
      _TechStackItem('Android Studio', 'assets/images/androidstudio.png'),
      _TechStackItem('Git', 'assets/images/git.png'),
      _TechStackItem('Docker', 'assets/images/docker.png'),
      _TechStackItem('Postman', 'assets/images/postman.png'),
      // Design
      _TechStackItem('Figma', 'assets/images/figma.png'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final int mobileColumns = 3;
        final int mobileRows = 2;
        final int mobileVisible = mobileColumns * mobileRows;
        final List<_TechStackItem> visibleTechs =
            isMobile && !_expanded ? techs.take(mobileVisible).toList() : techs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tech Stack', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? mobileColumns : 9,
                mainAxisSpacing: 6,
                crossAxisSpacing: 4,
                childAspectRatio: 0.95,
              ),
              itemCount: visibleTechs.length,
              itemBuilder: (context, i) {
                return _AnimatedTechStackWidget(
                  item: visibleTechs[i],
                  delay: Duration(milliseconds: 80 * i),
                  useCard: true,
                  small: true,
                );
              },
            ),
            if (isMobile && !_expanded && techs.length > mobileVisible)
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _expanded = true),
                  child: const Text('View All'),
                ),
              ),
            if (isMobile && _expanded && techs.length > mobileVisible)
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _expanded = false),
                  child: const Text('Show Less'),
                ),
              ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

class _TechStackItem {
  final String name;
  final String assetPath;
  const _TechStackItem(this.name, this.assetPath);
}

class _AnimatedTechStackWidget extends StatefulWidget {
  final _TechStackItem item;
  final Duration delay;
  final bool useCard;
  final bool small;
  const _AnimatedTechStackWidget({required this.item, required this.delay, this.useCard = false, this.small = false});

  @override
  State<_AnimatedTechStackWidget> createState() => _AnimatedTechStackWidgetState();
}

class _AnimatedTechStackWidgetState extends State<_AnimatedTechStackWidget> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Timer(widget.delay, () {
      if (mounted) setState(() => _opacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          widget.item.assetPath,
          width: 30,
          height: 30,
        ),
        const SizedBox(height: 4),
        Text(
          widget.item.name,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 400),
      child: widget.useCard
          ? Container(
              margin: const EdgeInsets.all(0.2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.015),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.white.withOpacity(0.03), width: 0.2),
              ),
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
              child: content,
            )
          : Container(
              alignment: Alignment.center,
              child: content,
            ),
    );
  }
}
