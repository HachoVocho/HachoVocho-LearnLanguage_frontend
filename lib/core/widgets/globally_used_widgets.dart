
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeStringsInSharedPreference(String key,String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<void> storeBoolInSharedPreference(String key,bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

  Widget buildTextWithIcon({
    required IconData icon,
    required String label,
    required String text,
    required String languageCode,
    required Color textColor,
    required Function(String) onTapWord,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label != '' ? Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ):Container(),
              const SizedBox(height: 4),
              Wrap(
                children: text.split(' ').map((word) {
                  return GestureDetector(
                    onTap: () => onTapWord(word),
                    child: Text(
                      '$word ',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.volume_up, color: Colors.deepPurple),
          onPressed: () {
            // Trigger full sentence playback
            onTapWord(text);
          },
        ),
      ],
    );
  }