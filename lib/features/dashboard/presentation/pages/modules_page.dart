import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/constants/hachovocho_learn_language_routes_name.dart';

class ModulesPage extends StatelessWidget {
  const ModulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the modules and their corresponding routes
    final List<Map<String, dynamic>> modules = [
      {
        'title': 'Listening',
        'icon': Icons.headset,
        'route': HachoVochoLearnLanguageRoutesName.userListeningTopicsProgress,
      },
      {
        'title': 'Writing',
        'icon': Icons.create,
        'route': HachoVochoLearnLanguageRoutesName.writingPractice,
      },
      {
        'title': 'Speaking',
        'icon': Icons.mic,
        'route': HachoVochoLearnLanguageRoutesName.speakingPractice,
      },
      {
        'title': 'Reading',
        'icon': Icons.book,
        'route': HachoVochoLearnLanguageRoutesName.readingPractice,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Choose a module to start learning:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              itemCount: modules.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two buttons per row
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 2, // Adjust as needed
              ),
              itemBuilder: (context, index) {
                final module = modules[index];
                return ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getString('user_id') ?? ''; // Replace 'myKey' with your actual key
                    Navigator.pushNamed(
                      context,
                      module['route'],
                      arguments: userId, // Pass the retrieved value as an argument
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        module['icon'],
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        module['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
