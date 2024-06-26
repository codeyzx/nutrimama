import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/presentation/register/register_controller.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

class RegisterFormSection extends ConsumerWidget {
  const RegisterFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign up',
            style: TypographyApp.headline1.medium,
          ),
          Gap.h36,
          InputFormWidget(
            controller: state.nameController,
            onChanged: (value) {},
            hintText: 'Full name',
            prefixIcon: Icons.person_outline_rounded,
            validator: controller.validateName,
          ),
          Gap.h16,
          InputFormWidget(
            controller: state.emailController,
            onChanged: (value) {},
            hintText: 'abc@gmail.com',
            prefixIcon: Icons.email_outlined,
            validator: controller.validateEmail,
          ),
          Gap.h16,
          InputFormWidget.password(
            controller: state.passwordController,
            onChanged: (value) {},
            hintText: 'Your Password',
            isObscure: state.isObscure,
            prefixIcon: Icons.lock_outline,
            onObscureTap: controller.onObscureTap,
            validator: controller.validatePassword,
          ),
          Gap.h16,
          InputFormWidget.password(
            controller: state.passwordConfirmController,
            onChanged: (value) {},
            hintText: 'Confirm Password',
            isObscure: state.isObscureConfirm,
            prefixIcon: Icons.lock_outline,
            onObscureTap: controller.onObscureConfirmTap,
            validator: controller.validatePasswordConfirm,
          ),
        ],
      ),
    );
  }
}
