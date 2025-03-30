import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hachovocho_learn_language/features/listeningPracticeHub/presentation/pages/user_listening_topics_progress_page.dart';
import 'package:hachovocho_learn_language/features/speakingPracticeHub/presentation/cubit/speakingPracticeHub_cubit.dart';
import 'package:hachovocho_learn_language/features/speakingPracticeHub/speakingPracticeHub_dependency_injection.dart';
import 'package:hachovocho_learn_language/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:hachovocho_learn_language/features/splash/presentation/pages/welcome_screen.dart';
import 'package:hachovocho_learn_language/features/splash/splash_dependency_injection.dart';

// Import all necessary pages
import '../features/listeningPracticeHub/domain/entities/getSentencesByTopic_listeningPracticeHub_params_entity.dart';
import '../features/listeningPracticeHub/domain/entities/getUserTopicsProgress_listeningPracticeHub_params_entity.dart';
import '../features/listeningPracticeHub/listeningPracticeHub_dependency_injection.dart';
import '../features/listeningPracticeHub/presentation/cubit/listeningPracticeHub_cubit.dart';
import '../features/listeningPracticeHub/presentation/pages/listening_practice_page.dart';
import '../features/speakingPracticeHub/domain/entities/getFaceToFaceConversations_speakingPracticeHub_params_entity.dart';
import '../features/speakingPracticeHub/presentation/pages/bot_conversation_chat_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/speakingPracticeHub/presentation/pages/face_to_face_conversation_page.dart';
import '../features/speakingPracticeHub/presentation/pages/past_conversations_page.dart';
import '../features/speakingPracticeHub/presentation/pages/practice_face_to_face_page.dart';
import '../features/speakingPracticeHub/presentation/pages/practice_with_bot_page.dart';
import '../features/speakingPracticeHub/presentation/pages/speaking_practice_page.dart'; // New SpeakingPracticePage

import '../features/splash/presentation/pages/splash_screen.dart';
import '../features/users/presentation/cubit/users_cubit.dart';

// Import Cubits
import '../features/speakingPracticeHub/presentation/cubit/bot_conversation_cubit.dart';
import '../features/speakingPracticeHub/presentation/cubit/face_to_face_conversation_cubit.dart';

// Import Route Names
import '../core/constants/hachovocho_learn_language_routes_name.dart';
import '../features/users/presentation/pages/user_login_page.dart';
import '../features/users/presentation/pages/user_otp_page.dart';
import '../features/users/presentation/pages/user_signup_page.dart';
import '../features/users/users_dependency_injection.dart';

class HachoVochoLearnLanguageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HachoVochoLearnLanguageRoutesName.splash:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<SplashCubit>(
                  create: (context) => SplashInstance<SplashCubit>(),
                ),
              ],
              child: SplashScreen(),
            ),
        );
      case HachoVochoLearnLanguageRoutesName.welcomePage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SplashCubit>(
            create: (context) => SplashInstance<SplashCubit>(), // Retrieve the cubit from GetIt
            child: WelcomePage(),
          ),
        );
      case HachoVochoLearnLanguageRoutesName.signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<UsersCubit>(
            create: (context) => UsersInstance<UsersCubit>(), // Retrieve the cubit from GetIt
            child: UserSignupPage(),
          ),
        );
      case HachoVochoLearnLanguageRoutesName.otp:
        final email = settings.arguments as String; // Extract email from arguments
        return MaterialPageRoute(
          builder: (context) => BlocProvider<UsersCubit>(
            create: (context) => UsersInstance<UsersCubit>(), // Retrieve the cubit from GetIt
            child: UserOtpPage(email: email),
          ),
        );
      case HachoVochoLearnLanguageRoutesName.login:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<UsersCubit>(
                  create: (context) => UsersInstance<UsersCubit>(),
                ),
              ],
              child: UserLoginPage(),
            ),
        );
      case HachoVochoLearnLanguageRoutesName.dashboard:
        return MaterialPageRoute(builder: (_) => UserDashboardPage());

      case HachoVochoLearnLanguageRoutesName.practiceFaceToFace:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FaceToFaceConversationCubit(),
            child: PracticeFaceToFacePage(),
          ),
        );

      case HachoVochoLearnLanguageRoutesName.faceToFaceConversation:
        final args = settings.arguments as Map<String, dynamic>?;
        // Optionally handle missing args or type mismatches
        final preferredLanguage = args?['preferredLanguage'] as String?;
        final learningLanguage = args?['learningLanguage'] as String?;
        final learningLanguageLevel = args?['learningLanguageLevel'] as String?;
        final userId = args?['userId'] as String?;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FaceToFaceConversationCubit(),
            child: FaceToFaceConversationPage(preferredLanguage: preferredLanguage,
          learningLanguage: learningLanguage,
          learningLanguageLevel: learningLanguageLevel,userId:userId),
          ),
        );

      case HachoVochoLearnLanguageRoutesName.practiceWithBot:
        return MaterialPageRoute(
          builder: (context) {
            final cubit = BotConversationCubit()..connectWebSocket();
            return BlocProvider(
              create: (_) => cubit,
              child: PracticeWithBotPage(cubit: cubit),
            );
          },
        );

      case HachoVochoLearnLanguageRoutesName.botConversationChat:
        return MaterialPageRoute(
          builder: (context) {
            final cubit = settings.arguments as BotConversationCubit;
            return BlocProvider.value(
              value: cubit,
              child: BotConversationChatPage(),
            );
          },
        );

      case HachoVochoLearnLanguageRoutesName.listeningPractice:
        final paramData = settings.arguments as List;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ListeningpracticehubCubit>(
                create: (context) => ListeningpracticehubInstance<ListeningpracticehubCubit>()..getsentencesbytopicListeningpracticehub(
                  GetsentencesbytopicListeningpracticehubParamsEntity(topicId: paramData[1],userId: paramData[0])
                )
              ),
            ],
            child: ListeningPracticePage(userId: paramData[0]),
          ),
        );

      case HachoVochoLearnLanguageRoutesName.userListeningTopicsProgress:
        final userId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ListeningpracticehubCubit>(
                create: (context) => ListeningpracticehubInstance<ListeningpracticehubCubit>()..getusertopicsprogressListeningpracticehub(
                  GetusertopicsprogressListeningpracticehubParamsEntity(userId: userId)
                ),
              ),
            ],
            child: UserListeningTopicsProgressPage(userId: userId),
          ),
        );


      case HachoVochoLearnLanguageRoutesName.speakingPractice:
        return MaterialPageRoute(
          builder: (_) => SpeakingPracticePage(),
        );

      case HachoVochoLearnLanguageRoutesName.pastConversations:
        final userId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<SpeakingpracticehubCubit>(
                create: (context) => SpeakingpracticehubInstance<SpeakingpracticehubCubit>()..getfacetofaceconversationsSpeakingpracticehub(
                  GetfacetofaceconversationsSpeakingpracticehubParamsEntity(userId: userId)
                ),
              ),
              BlocProvider<FaceToFaceConversationCubit>(
                create: (context) => SpeakingpracticehubInstance<FaceToFaceConversationCubit>()
              ),
            ],
            child: PastConversationsPage(userId: userId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
