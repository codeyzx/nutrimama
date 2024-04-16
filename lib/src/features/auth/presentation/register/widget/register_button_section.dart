import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/features/auth/presentation/register/register_controller.dart';

class RegisterButtonSection extends ConsumerWidget {
  const RegisterButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonWidget.primary(
          text: 'SIGN UP',
          onTap: controller.register,
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
