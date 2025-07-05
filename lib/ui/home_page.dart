import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/tech_stack_section.dart';
import 'sections/education_section.dart';
import 'sections/certifications_section.dart';
import 'sections/footer_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if we're on a small screen
          final bool isSmallScreen = constraints.maxWidth < 768;
          
          // Calculate the width based on screen size
          double contentWidth = isSmallScreen 
              ? constraints.maxWidth
              : constraints.maxWidth > 1200 
                  ? 800
                  : constraints.maxWidth * 0.7;

          // Apply side padding for small screens
          final sidePadding = isSmallScreen 
              ? (constraints.maxWidth < 400 ? 16.0 : 24.0) 
              : 0.0;

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePadding),
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      const CustomAppBar(),
                      const HeroSection(),
                      const ProjectsSection(),
                      const TechStackSection(),
                      const EducationSection(),
                      const CertificationsSection(),
                      const FooterSection(),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}