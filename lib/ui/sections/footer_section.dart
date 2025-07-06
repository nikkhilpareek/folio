import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
            children: [
              const TextSpan(text: 'Made by '),
              TextSpan(
                text: 'Nikhil Pareek',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const TextSpan(text: ' with a lot of caffeine'),
              TextSpan(
                text: ' ☕',
                style: const TextStyle(fontStyle: FontStyle.normal),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
