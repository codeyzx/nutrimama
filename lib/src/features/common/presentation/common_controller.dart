import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrimama/src/features/common/data/common_repository.dart';
import 'package:nutrimama/src/features/common/presentation/common_state.dart';
import 'package:nutrimama/src/features/home/presentation/home_screen.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common_controller.g.dart';

// TODO: autoset botnavbar jadi index awal sama getprofile buat reload dll
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
          ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
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
      isAnalyzeActive: index == 1,
      isRecycleActive: index == 3,
      isProfileActive: index == 4,
    );
  }

  Widget _getScreen(index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const HomeScreen();
      case 3:
        return const HomeScreen();
      case 4:
        return const HomeScreen();
      default:
        return const HomeScreen();
    }
  }

  Future<void> getProfile() async {
    state = state.copyWith(
      userValue: const AsyncLoading(),
    );

    final result = await ref.read(commonRepositoryProvider).getProfile();
    result.when(
      success: (data) {
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
