import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/shared/extensions/build_context.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(commonControllerProvider.notifier).checkSplash();

    return StatusBarWidget(
      child: Scaffold(
        body: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Column(
            children: [
              const Spacer(flex: 4),
              Assets.images.nutrimamaLogo.svg(
                width: context.screenWidthPercentage(0.6),
                fit: BoxFit.fitWidth,
              ),
              const Spacer(flex: 4),
              Text("By", style: TypographyApp.splashBy),
              Text("ORBIT", style: TypographyApp.splashTeamName),
              Gap.h28
            ],
          ),
        ),
      ),
    );
  }
}
