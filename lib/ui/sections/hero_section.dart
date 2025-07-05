import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/hero.jpg',
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            child: _buildOpenForWorkChip(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Welcome to My Portfolio",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "I'm a Computer Science undergrad passionate about building clean, functional mobile apps using Flutter. Currently exploring the world of app development, I'm gaining hands-on experience through internships, projects, and constant learning.",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _buildResumeButton(),
                  ],
                )
              : Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome to My Portfolio",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.displayLarge?.color,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 400,
                            child: Text(
                              "I'm a Computer Science undergrad passionate about building clean, functional mobile apps using Flutter. Currently exploring the world of app development, I'm gaining hands-on experience through internships, projects, and constant learning.",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildResumeButton(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48, height: 48),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/hero.jpg',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              child: _buildOpenForWorkChip(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildOpenForWorkChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00E676),
            const Color(0xFF00C853),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E676).withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Open to Work!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
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

class _ResumeHoverButtonState extends State<_ResumeHoverButton>
    with TickerProviderStateMixin {
  bool _hovering = false;
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;
  late Animation<double> _rippleOpacity;
  Offset _rippleCenter = Offset.zero;
  GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOutQuart,
    ));
    _rippleOpacity = Tween<double>(
      begin: 0.8,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  void _startRipple(Offset globalPosition) {
    RenderBox? renderBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Offset localPosition = renderBox.globalToLocal(globalPosition);
      setState(() {
        _rippleCenter = localPosition;
      });
      _rippleController.reset();
      _rippleController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovering = true);
      },
      onExit: (_) {
        setState(() => _hovering = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.blue.shade300.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            key: _buttonKey,
            children: [
              // Background button
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 260,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _hovering
                        ? [Colors.blue.shade600, Colors.blue.shade800]
                        : [Colors.grey.shade700, Colors.grey.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Ripple effect
              AnimatedBuilder(
                animation: _rippleAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _RipplePainter(
                      center: _rippleCenter,
                      radius: _rippleAnimation.value * 300,
                      opacity: _rippleOpacity.value,
                    ),
                    size: const Size(260, 50),
                  );
                },
              ),
              // Button content
              Container(
                width: 260,
                height: 50,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      try {
                        // Load the PDF from assets
                        final ByteData data = await rootBundle.load('assets/resume.pdf');
                        final Uint8List bytes = data.buffer.asUint8List();
                        
                        // Create a blob and download it
                        final blob = html.Blob([bytes]);
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        final anchor = html.document.createElement('a') as html.AnchorElement
                          ..href = url
                          ..style.display = 'none'
                          ..download = 'Nikhil_Pareek_Resume.pdf';
                        html.document.body?.children.add(anchor);
                        anchor.click();
                        html.document.body?.children.remove(anchor);
                        html.Url.revokeObjectUrl(url);
                      } catch (e) {
                        // Handle error - show a snackbar or dialog
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error downloading resume. Please try again.'),
                            ),
                          );
                        }
                      }
                    },
                    onTapDown: (details) {
                      _startRipple(details.globalPosition);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Download Resume',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(left: _hovering ? 8 : 4),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 16,
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
        ),
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  final Offset center;
  final double radius;
  final double opacity;

  _RipplePainter({
    required this.center,
    required this.radius,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity > 0) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(opacity * 0.3)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
