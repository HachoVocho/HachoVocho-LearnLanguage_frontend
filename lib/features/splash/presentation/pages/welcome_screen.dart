import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/getStaticStrings_splash_params_entity.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final List<String> _languages = ['English', 'German','Spanish','French'];
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is GetstaticstringsSplashSuccess) {
          // Navigate to the sign-up page with the data
          Navigator.pushNamed(
            context,
            '/login',
          );
        } else if (state is GetstaticstringsSplashError) {
          // Show an error message via SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SplashLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Welcome'),
            backgroundColor: Colors.deepPurple,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select a language',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedLanguage,
                  items: _languages
                      .map((lang) => DropdownMenuItem<String>(
                            value: lang,
                            child: Text(lang),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _selectedLanguage = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_selectedLanguage != null) {
                            final params = GetstaticstringsSplashParamsEntity(
                              lang: _selectedLanguage!,
                            );
                            context
                                .read<SplashCubit>()
                                .getstaticstringsSplash(params);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a language'),
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Proceed to Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
