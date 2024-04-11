import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/src/features/auth/presentation/login/login_page.dart';
import 'package:nutrimama/src/features/auth/presentation/register/register_page.dart';
import 'package:nutrimama/src/features/chatbot/presentation/chatbot_screen.dart';
import 'package:nutrimama/src/features/common/presentation/botnavbar/botnavbar_page.dart';
import 'package:nutrimama/src/features/common/presentation/onboard/onboard_page.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_edit_screen.dart';
import 'package:nutrimama/src/features/common/presentation/splash/splash_screen.dart';
import 'package:nutrimama/src/features/medical_record/presentation/add_fetal_record_screen.dart';
import 'package:nutrimama/src/features/medical_record/presentation/add_mother_record_screen.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_screen.dart';
import 'package:nutrimama/src/routes/error_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_routes.g.dart';

enum Routes {
  splash,
  onboard,
  register,
  login,
  botNavBar,
  chatbot,
  profileEdit,
  medicalRecord,
  addFetalRecord,
  addMotherRecord,
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    routerNeglect: true,
    redirectLimit: 1,
    routes: [
      GoRoute(
        path: '/splash',
        name: Routes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboard',
        name: Routes.onboard.name,
        builder: (context, state) => const OnboardPage(),
      ),
      GoRoute(
        path: '/register',
        name: Routes.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/login',
        name: Routes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/botNavBar',
        name: Routes.botNavBar.name,
        builder: (context, state) => const BotNavBarPage(),
      ),
      GoRoute(
        path: '/chatbot',
        name: Routes.chatbot.name,
        builder: (context, state) => const ChatbotScreen(),
      ),
      GoRoute(
        path: '/profileEdit',
        name: Routes.profileEdit.name,
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: '/medicalRecord',
        name: Routes.medicalRecord.name,
        builder: (context, state) => const MedicalRecordScreen(),
      ),
      GoRoute(
        path: '/addFetalRecord',
        name: Routes.addFetalRecord.name,
        builder: (context, state) => const AddFetalRecordScreen(),
      ),
      GoRoute(
        path: '/addMotherRecord',
        name: Routes.addMotherRecord.name,
        builder: (context, state) => const AddMotherRecordScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
  );
}
