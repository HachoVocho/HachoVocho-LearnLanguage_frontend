import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/getStaticStrings_splash_params_entity.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashScreen extends StatefulWidget {
  final String? mobileNo;
  final String? paymentId;

  const SplashScreen({super.key, this.mobileNo, this.paymentId});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeSplash();
  }

  Future<void> _initializeSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if language is selected
    final bool isLanguageSelected = prefs.containsKey('is_app_language_selected_by_user');
    final bool isUserLoggedIn = prefs.getBool('is_user_logged_in') ?? false;
    final String sharedPrefValue = prefs.getString('is_app_language_selected_by_user') ?? 'en-US';

    // Fetch static strings
    await context.read<SplashCubit>().getstaticstringsSplash(
          GetstaticstringsSplashParamsEntity(lang: sharedPrefValue),
        );

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) async {
        if (state is GetstaticstringsSplashSuccess) {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // Check if language is selected
          final bool isLanguageSelected = prefs.containsKey('is_app_language_selected_by_user');
          final bool isUserLoggedIn = prefs.getBool('is_user_logged_in') ?? false;
          if (isLanguageSelected) {
            isUserLoggedIn
                ? Navigator.pushReplacementNamed(context, '/dashboard')
                : Navigator.pushReplacementNamed(context, '/login');
          } else {
            Navigator.pushReplacementNamed(context, '/welcome_page');
          }
        } else if (state is GetstaticstringsSplashError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is SplashLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text('Initializing...'),
          ),
        );
      },
    );
  }
}
