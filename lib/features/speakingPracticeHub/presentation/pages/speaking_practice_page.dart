import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpeakingPracticePage extends StatelessWidget {
  const SpeakingPracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Speaking Practice',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPracticeCard(
                context: context,
                title: 'Practice a language with a bot',
                description: 'Learn and improve your skills by talking with an AI-powered bot.',
                onTap: () {
                  Navigator.pushNamed(context, '/practiceWithBot');
                },
                onConversationsTap: () {
                  Navigator.pushNamed(context, '/myBotConversations');
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
                onConversationsTap: () {
                  Navigator.pushNamed(context, '/myBuddyConversations');
                },
              ),
              const SizedBox(height: 16),
              _buildPracticeCard(
                context: context,
                title: 'Practice a language face to face',
                description: 'Connect with someone nearby who knows the language you want to learn and practice face-to-face.',
                onTap: () {
                  Navigator.pushNamed(context, '/practiceFaceToFace');
                },
                onConversationsTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final userId = prefs.getString('user_id') ?? ''; // Replace 'myKey' with your actual key
                  Navigator.pushNamed(
                    context,
                    '/pastConversations',
                    arguments: userId, // Pass the retrieved value as an argument
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPracticeCard({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onTap,
    required VoidCallback onConversationsTap,
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
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onConversationsTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'My Conversations',
                    style: TextStyle(color: Colors.white),
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
