import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrimama/src/features/common/data/common_repository.dart';
import 'package:nutrimama/src/features/common/presentation/common_state.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_screen.dart';
import 'package:nutrimama/src/features/common/presentation/home/home_screen.dart';
import 'package:nutrimama/src/features/community/presentation/community_screen.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/education/presentation/education_screen.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'common_controller.g.dart';

@Riverpod(keepAlive: true)
class CommonController extends _$CommonController {
  @override
  CommonState build() {
    return CommonState();
  }

  void setLastPage(bool value) {
    state = state.copyWith(
      isLastPage: value,
    );
  }

  Future<bool> isOnboarded() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'onboard');
    if (value == null) {
      await storage.write(key: 'onboard', value: 'true');
      return false;
    }
    return true;
  }

  void checkSplash() {
    Future.delayed(const Duration(seconds: 3), () async {
      final isNewUser = await isOnboarded();
      if (isNewUser) {
        final isLogin = ref.read(commonRepositoryProvider).isLogin();
        if (isLogin) {
          await getProfile();
          final isSuccessRegister =
              state.userValue.asData?.value.isSuccessRegister ?? false;
          if (isSuccessRegister) {
            final uid = getUid();

            await ref
                .read(nutritionControllerProvider.notifier)
                .getNutrition(uid);
            await ref
                .read(consumeLogControllerProvider.notifier)
                .getConsumeLogs(uid);
            await ref
                .read(consumeLogControllerProvider.notifier)
                .getTodayConsumeFood(uid, DateTime.now().toYyyyMMDd);
            await ref
                .read(consumeLogControllerProvider.notifier)
                .getTodayConsumeLog(uid, DateTime.now().toYyyyMMDd);
            ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
          } else {
            ref.read(goRouterProvider).goNamed(Routes.question.name);
          }
        } else {
          ref.read(goRouterProvider).goNamed(Routes.login.name);
        }
      } else {
        ref.read(goRouterProvider).goNamed(Routes.onboard.name);
      }
    });
  }

  void setPage(index) {
    state = state.copyWith(
      currentIndex: index,
      currentScreen: _getScreen(index),
      isHomeActive: index == 0,
      isCommunityActive: index == 1,
      isEduActive: index == 3,
      isProfileActive: index == 4,
    );
  }

  Widget _getScreen(index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CommunityScreen();
      case 3:
        return const EducationScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  String getUid() {
    return ref.read(commonRepositoryProvider).getUid() ?? '';
  }

  Future<void> getProfile() async {
    state = state.copyWith(
      userValue: const AsyncLoading(),
    );

    final result = await ref.read(commonRepositoryProvider).getProfile();
    result.when(
      success: (data) {
        Logger().i(data.toJson());
        state = state.copyWith(
          userValue: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          userValue: AsyncError(error, stackTrace),
        );
      },
    );
  }
}
