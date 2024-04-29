import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/presentation/login/login_controller.dart';
import 'package:nutrimama/src/features/auth/presentation/login/widget/login_button_section.dart';
import 'package:nutrimama/src/features/auth/presentation/login/widget/login_form_section.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:nutrimama/src/shared/extensions/build_context.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginControllerProvider, (prevState, state) {
      if (prevState?.loginValue != state.loginValue) {
        state.loginValue.whenOrNull(
          data: (data) async {
            await ref.read(commonControllerProvider.notifier).getProfile();
          },
          error: (error, stackTrace) {
            final message =
                NetworkExceptions.getErrorMessage(error as NetworkExceptions);
            appSnackBar(context, ColorApp.red, message);
          },
        );
      }
    });

    ref.listen(commonControllerProvider, (previous, next) {
      if (previous?.userValue != next.userValue) {
        next.userValue.whenOrNull(
          data: (data) async {
            final uid = ref.read(commonControllerProvider.notifier).getUid();
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
            ref.read(consumeLogControllerProvider.notifier).getDate();
            ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
          },
          error: (error, stackTrace) {
            final message =
                NetworkExceptions.getErrorMessage(error as NetworkExceptions);
            appSnackBar(context, ColorApp.red, message);
          },
        );
      }
    });

    return StatusBarWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PaddingWidget(
              child: Column(
                children: [
                  const Spacer(),
                  Center(
                    child: Assets.icons.icLauncher.image(
                      width: context.screenWidthPercentage(.5),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Gap.h32,
                  const LoginFormSection(),
                  Gap.h32,
                  const LoginButtonSection(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TypographyApp.headline3,
                      ),
                      Gap.w8,
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.register.name);
                        },
                        child: Text(
                          'Sign Up',
                          style: TypographyApp.headline3.copyWith(
                            color: ColorApp.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap.h36
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
