import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/hachovocho_learn_language_routes_name.dart';
import 'core/constants/strings.dart';
import 'routes/hachovocho_learn_language_router.dart';
import 'features/users/users_dependency_injection.dart' as userInstance;
import 'features/splash/splash_dependency_injection.dart' as splashInstance;
import 'features/listeningPracticeHub/listeningPracticeHub_dependency_injection.dart' as listeningpracticehubInstance;
import 'features/speakingPracticeHub/speakingPracticeHub_dependency_injection.dart' as speakingpracticehubInstance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await userInstance.init();
  await splashInstance.init();
  await listeningpracticehubInstance.init();
  await speakingpracticehubInstance.init();
  // Initialize shared preferences and other resources
  final String initialRoute = await _initializeApp();

  // Start the app
  runApp(MyApp(initialRoute: initialRoute));
}

Future<String> _initializeApp() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    // Set the development base URL (can be made environment-specific)
    await prefs.setString(
      'development_base_url',
      'https://51.20.255.49/',
      //'https://b8ac-2001-9e8-73e-6b00-89d9-4ebd-2a75-c69.ngrok-free.app/'
    );

    return HachoVochoLearnLanguageRoutesName.splash;
  } catch (e, stackTrace) {
    print('Error during app initialization: $e\n$stackTrace');
    // Fallback to splash route on error
    return '';
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TgStrings.appTitle,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(14),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ),
      initialRoute: initialRoute, // Dynamic initial route
      onGenerateRoute: HachoVochoLearnLanguageRouter.generateRoute, // Use router
    );
  }
}
