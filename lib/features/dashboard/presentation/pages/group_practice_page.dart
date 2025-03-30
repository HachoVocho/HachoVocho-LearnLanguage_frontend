import 'package:flutter/material.dart';

class GroupPracticePage extends StatelessWidget {
  const GroupPracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPracticeCard(
              context: context,
              title: 'Practice a language with a bot',
              description: 'Learn and improve your skills by talking with an AI-powered bot.',
              onTap: () {
                // Navigate to Practice with Bot Page
                Navigator.pushNamed(context, '/practiceWithBot');
              },
            ),
            const SizedBox(height: 16),
            _buildPracticeCard(
              context: context,
              title: 'Practice a language with a buddy',
              description: 'Pair up with a buddy to practice speaking and learning together.',
              onTap: () {
                Navigator.pushNamed(context, '/practiceWithBuddy');
              },
            ),
            const SizedBox(height: 16),
            _buildPracticeCard(
              context: context,
              title: 'Practice a language face to face',
              description: 'Connect with someone nearby who knows the language you want to learn and practice face-to-face',
              onTap: () {
                // Navigate to Face-to-Face Practice Page
                Navigator.pushNamed(context, '/practiceFaceToFace');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeCard({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
