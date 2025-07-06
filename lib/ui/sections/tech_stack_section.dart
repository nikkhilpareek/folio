import 'package:flutter/material.dart';
import 'dart:async';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

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
        final bool isMobile = constraints.maxWidth < 700;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tech Stack', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: isMobile ? 16.0 : 40.0,
              runSpacing: isMobile ? 16.0 : 24.0,
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              children: List.generate(
                techs.length,
                (i) => _AnimatedTechStackWidget(
                  item: techs[i],
                  delay: Duration(milliseconds: 100 * i),
                ),
              ),
            ),
            const SizedBox(height: 32),
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
  const _AnimatedTechStackWidget({required this.item, required this.delay});

  @override
  State<_AnimatedTechStackWidget> createState() =>
      _AnimatedTechStackWidgetState();
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
    final isMobile = MediaQuery.of(context).size.width < 700;
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            widget.item.assetPath,
            width: isMobile ? 28 : 32,
            height: isMobile ? 28 : 32,
          ),
          SizedBox(height: isMobile ? 6 : 8),
          Text(
            widget.item.name, 
            style: TextStyle(fontSize: isMobile ? 12 : 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
