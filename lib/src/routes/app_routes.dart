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
import 'package:nutrimama/src/features/common/presentation/profile/presentation/terms_and_conditions_screen.dart';
import 'package:nutrimama/src/features/common/presentation/question/question_page.dart';
import 'package:nutrimama/src/features/common/presentation/splash/splash_screen.dart';
import 'package:nutrimama/src/features/community/presentation/add_post_screen.dart';
import 'package:nutrimama/src/features/community/presentation/detail_post_screen.dart';
import 'package:nutrimama/src/features/education/presentation/article/detail_article_screen.dart';
import 'package:nutrimama/src/features/education/presentation/video/detail_video_screen.dart';
import 'package:nutrimama/src/features/education/presentation/video/video_screen.dart';
import 'package:nutrimama/src/features/food/presentation/detail_food_screen.dart';
import 'package:nutrimama/src/features/food/presentation/food_screen.dart';
import 'package:nutrimama/src/features/food/presentation/search_food_screen.dart';
import 'package:nutrimama/src/features/journal/presentation/add_journal_screen.dart';
import 'package:nutrimama/src/features/journal/presentation/detail_journal_screen.dart';
import 'package:nutrimama/src/features/journal/presentation/journal_screen.dart';
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
  question,
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
  food,
  detailFood,
  searchFood,
  detailPost,
  addPost,
  detailArticle,
  video,
  detailVideo,
  journal,
  detailJournal,
  addJournal,
  snk,
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
        path: '/question',
        name: Routes.question.name,
        builder: (context, state) => const QuestionPage(),
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
          final isNewFetal = extras.datas[ExtrasKey.isNewFetal] as bool;
          return AddFetalRecordScreen(user: user, isNewFetal: isNewFetal);
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
      GoRoute(
        path: '/food',
        name: Routes.food.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final consumeAt = extras.datas[ExtrasKey.consumeAt] as String;
          return FoodScreen(consumeAt: consumeAt);
        },
      ),
      GoRoute(
        path: '/searchFood',
        name: Routes.searchFood.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final consumeAt = extras.datas[ExtrasKey.consumeAt] as String;
          return SearchFoodScreen(consumeAt: consumeAt);
        },
      ),
      GoRoute(
        path: '/detailFood',
        name: Routes.detailFood.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final food = extras.datas[ExtrasKey.food];
          final consumeAt = extras.datas[ExtrasKey.consumeAt] as String;
          return DetailFoodScreen(food: food, consumeAt: consumeAt);
        },
      ),
      GoRoute(
        path: '/detailPost',
        name: Routes.detailPost.name,
        builder: (context, state) => const DetailPostScreen(),
      ),
      GoRoute(
        path: '/addPost',
        name: Routes.addPost.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final user = extras.datas[ExtrasKey.user] as User;
          return AddPostScreen(user: user);
        },
      ),
      GoRoute(
        path: '/detailArticle',
        name: Routes.detailArticle.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final article = extras.datas[ExtrasKey.article];
          return DetailArticleScreen(article: article);
        },
      ),
      GoRoute(
        path: '/video',
        name: Routes.video.name,
        builder: (context, state) => const VideoScreen(),
      ),
      GoRoute(
        path: '/detailVideo',
        name: Routes.detailVideo.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final video = extras.datas[ExtrasKey.video];
          return DetailVideoScreen(video: video);
        },
      ),
      GoRoute(
          path: '/journal',
          name: Routes.journal.name,
          builder: (context, state) {
            final extras = state.extra as Extras;
            final user = extras.datas[ExtrasKey.user] as User;
            return JournalScreen(user: user);
          }),
      GoRoute(
        path: '/detailJournal',
        name: Routes.detailJournal.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final journal = extras.datas[ExtrasKey.journal];
          final imageUrl = extras.datas[ExtrasKey.imageUrl];
          return DetailJournalScreen(journal: journal, imageUrl: imageUrl);
        },
      ),
      GoRoute(
        path: '/addJournal',
        name: Routes.addJournal.name,
        builder: (context, state) {
          final extras = state.extra as Extras;
          final user = extras.datas[ExtrasKey.user] as User;
          return AddJournalScreen(user: user);
        },
      ),
      GoRoute(
        path: '/snk',
        name: Routes.snk.name,
        builder: (context, state) => const TermsAndConditionsScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
  );
}
