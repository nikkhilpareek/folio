import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Text(
          'made by Nikhil Pareek with a lot of caffeine and Prompts',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
