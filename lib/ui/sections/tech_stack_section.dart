import 'package:flutter/material.dart';
import 'dart:async';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final techs = [
      _TechStackItem('Flutter', 'assets/images/flutter.png'),
      _TechStackItem('Dart', 'assets/images/dart.png'),
      _TechStackItem('C++', 'assets/images/cpp.png'),
      _TechStackItem('Firebase', 'assets/images/firebase.png'),
      _TechStackItem('FastAPI', 'assets/images/fapi.png'),
      _TechStackItem('Figma', 'assets/images/figma.png'),
      _TechStackItem('Git', 'assets/images/git.png'),
      _TechStackItem('Solidity', 'assets/images/solidity.png'),
      _TechStackItem('SQL', 'assets/images/sql.png'),
      _TechStackItem('VS Code', 'assets/images/vsc.png'),
    ];
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tech Stack', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 16),
            isMobile
                ? Wrap(
                    spacing: 32.0,
                    runSpacing: 20.0,
                    children: List.generate(
                      techs.length,
                      (i) => _AnimatedTechStackWidget(
                        item: techs[i],
                        delay: Duration(milliseconds: 100 * i),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        techs.length,
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _AnimatedTechStackWidget(
                            item: techs[i],
                            delay: Duration(milliseconds: 100 * i),
                          ),
                        ),
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
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            widget.item.assetPath,
            width: 32,
            height: 32,
          ),
          const SizedBox(height: 8),
          Text(widget.item.name, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
