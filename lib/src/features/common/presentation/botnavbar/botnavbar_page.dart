import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';

class BotNavBarPage extends ConsumerWidget {
  const BotNavBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commonControllerProvider);
    final controller = ref.read(commonControllerProvider.notifier);
    final currentIndex = state.currentIndex;
    final currentScreen = state.currentScreen;
    final bucket = PageStorageBucket();

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: ColorApp.primary,
              child: Assets.icons.icChatbot.svg(
                width: 28.w,
                height: 28.h,
              ),
              onPressed: () {
                ref.read(goRouterProvider).pushNamed(Routes.chatbot.name);
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: ColorApp.black,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10.0.sp,
          unselectedFontSize: 10.0.sp,
          type: BottomNavigationBarType.fixed,
          iconSize: 24.0.sp,
          currentIndex: currentIndex,
          onTap: (index) => controller.setPage(index),
          items: [
            BottomNavigationBarItem(
              icon: !state.isHomeActive
                  ? Assets.icons.icHomeOff.svg()
                  : Assets.icons.icHomeOn.svg(),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: !state.isCommunityActive
                  ? Assets.icons.icCommunityOff.svg()
                  : Assets.icons.icCommunityOn.svg(),
              label: 'Komunitas',
            ),
            BottomNavigationBarItem(icon: SizedBox(width: 40.w), label: ''),
            BottomNavigationBarItem(
              icon: !state.isEduActive
                  ? Assets.icons.icEduOff.svg()
                  : Assets.icons.icEduOn.svg(),
              label: 'Edukasi',
            ),
            BottomNavigationBarItem(
              icon: !state.isProfileActive
                  ? Assets.icons.icProfileOff.svg()
                  : Assets.icons.icProfileOn.svg(),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
