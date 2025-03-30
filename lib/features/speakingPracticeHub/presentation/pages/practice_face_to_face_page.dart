import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/face_to_face_cubit.dart';
import '../cubit/face_to_face_state.dart';
class PracticeFaceToFacePage extends StatelessWidget {
   PracticeFaceToFacePage({super.key});

  final List<String> languages = ['English', 'German','Spanish','French'];
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];
  final List<String> topics = ['Greetings', 'Food', 'Travel', 'Work'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FaceToFaceCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Face-to-Face Practice', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FaceToFaceCubit, FaceToFaceState>(
            builder: (context, state) {
              final cubit = context.read<FaceToFaceCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Set your preferences',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    label: 'Your Preferred Language',
                    value: state.preferredLanguage,
                    items: languages,
                    onChanged: (value) => cubit.updatePreferredLanguage(value),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    label: "Your learning Language",
                    value: state.learningLanguage,
                    items: languages,
                    onChanged: (value) => cubit.updateLearningLanguage(value),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    label: 'Learning Language Level you want to practice',
                    value: state.level,
                    items: levels,
                    onChanged: (value) => cubit.updateLevel(value),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (state.preferredLanguage != null && 
                          state.learningLanguage != null && 
                          state.level != null) {
                        final prefs = await SharedPreferences.getInstance();
                        final userId = prefs.getString('user_id') ?? '';
                        // example: navigate to the conversation page
                        Navigator.pushNamed(
                          context,
                          '/faceToFaceConversation',
                          arguments: {
                            'preferredLanguage': state.preferredLanguage,
                            'learningLanguage': state.learningLanguage,
                            'learningLanguageLevel': state.level,
                            'userId': userId
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all required fields'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Start Conversation', style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
