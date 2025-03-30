import 'package:flutter/material.dart';

class PracticeSentencesPage extends StatelessWidget {
  final String preferredLanguage;
  final String languageToLearn;
  final String languageLevel;
  final String topic;

  const PracticeSentencesPage({
    super.key,
    required this.preferredLanguage,
    required this.languageToLearn,
    required this.languageLevel,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Practice Sentences',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display selected preferences in a styled card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPreferenceRow(
                      label: 'Preferred Language:',
                      value: preferredLanguage,
                    ),
                    const SizedBox(height: 8),
                    _buildPreferenceRow(
                      label: 'Language to Learn:',
                      value: languageToLearn,
                    ),
                    const SizedBox(height: 8),
                    _buildPreferenceRow(
                      label: 'Level:',
                      value: languageLevel,
                    ),
                    const SizedBox(height: 8),
                    _buildPreferenceRow(
                      label: 'Topic:',
                      value: topic,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title for Practice Sentences
            const Text(
              'Practice Sentences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),

            // List of Practice Sentences
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Sentence ${index + 1}'),
                      subtitle: Text('This is sentence ${index + 1} for practice.'),
                    ),
                  );
                },
              ),
            ),

            // Go Back Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size.fromHeight(50), // Ensures the button covers the full width
              ),
              child: const Text(
                'Go Back',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceRow({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
