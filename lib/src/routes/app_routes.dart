import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/auth/presentation/login/login_page.dart';
import 'package:nutrimama/src/features/auth/presentation/register/register_page.dart';
import 'package:nutrimama/src/features/chatbot/presentation/chatbot_screen.dart';
import 'package:nutrimama/src/features/common/presentation/botnavbar/botnavbar_page.dart';
import 'package:nutrimama/src/features/common/presentation/onboard/onboard_page.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_edit_screen.dart';
import 'package:nutrimama/src/features/common/presentation/splash/splash_screen.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/features/medical_record/domain/mother.dart';
import 'package:nutrimama/src/features/medical_record/presentation/add_fetal_record_screen.dart';
import 'package:nutrimama/src/features/medical_record/presentation/add_mother_record_screen.dart';
import 'package:nutrimama/src/features/medical_record/presentation/fetal_record_screen.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_screen.dart';
import 'package:nutrimama/src/features/medical_record/presentation/mother_record_screen.dart';
import 'package:nutrimama/src/routes/routes.dart';
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
  motherRecord,
  fetalRecord,
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
        builder: (context, state) {
          final extras = state.extra as Extras;
          final user = extras.datas[ExtrasKey.user] as User;
          return MedicalRecordScreen(user: user);
        },
      ),
      GoRoute(
        path: '/addFetalRecord',
        name: Routes.addFetalRecord.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final user = extras.datas[ExtrasKey.user] as User;
          return AddFetalRecordScreen(user: user);
        },
      ),
      GoRoute(
        path: '/addMotherRecord',
        name: Routes.addMotherRecord.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final user = extras.datas[ExtrasKey.user] as User;
          return AddMotherRecordScreen(user: user);
        },
      ),
      GoRoute(
        path: '/motherRecord',
        name: Routes.motherRecord.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final mothers = extras.datas[ExtrasKey.mothers] as List<Mother>;
          final mother = extras.datas[ExtrasKey.mother] as Mother;
          return MotherRecordScreen(mothers: mothers, mother: mother);
        },
      ),
      GoRoute(
        path: '/fetalRecord',
        name: Routes.fetalRecord.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final fetals = extras.datas[ExtrasKey.fetals] as List<Fetal>;
          final fetal = extras.datas[ExtrasKey.fetal] as Fetal;
          return FetalRecordScreen(fetals: fetals, fetal: fetal);
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
  );
}
