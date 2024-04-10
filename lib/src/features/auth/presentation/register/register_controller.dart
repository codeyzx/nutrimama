import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/data/auth_repository.dart';
import 'package:nutrimama/src/features/auth/domain/request_register.dart';
import 'package:nutrimama/src/features/auth/presentation/register/register_state.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  RegisterState build() {
    return RegisterState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      passwordConfirmController: TextEditingController(),
    );
  }

  Future<void> register() async {
    if (!state.formKey.currentState!.validate()) {
      return;
    }

    state = state.copyWith(
      registerValue: const AsyncLoading(),
    );

    final requestRegister = RequestRegister(
      name: state.nameController.text,
      email: state.emailController.text,
      password: state.passwordController.text,
    );

    final result =
        await ref.read(authRepositoryProvider).register(requestRegister);

    result.when(
      success: (data) {
        state = state.copyWith(
          registerValue: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        final errors = NetworkExceptions.getErrors(error);

        state = state.copyWith(
          registerValue: AsyncError(error, stackTrace),
          errors: errors,
        );
      },
    );
  }

  void onObscureTap() {
    state = state.copyWith(
      isObscure: !state.isObscure,
    );
  }

  void onObscureConfirmTap() {
    state = state.copyWith(
      isObscureConfirm: !state.isObscureConfirm,
    );
  }

  void onRoleValueChanged(value) {
    state = state.copyWith(
      roleValue: value,
    );
  }

  String? validateName(String? value) {
    if (value.isNullOrEmpty()) {
      return "Cannot be empty";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value.isNullOrEmpty()) {
      return "Cannot be empty";
    } else if (!value!.isEmailValid) {
      return "email not valid";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value.isNullOrEmpty()) {
      return "Cannot be empty";
    } else if (!value!.isPasswordValid) {
      return "Password must be more than 8";
    }
    return null;
  }

  String? validatePasswordConfirm(String? value) {
    if (value.isNullOrEmpty()) {
      return "Cannot be empty";
    } else if (!value!.isPasswordValid) {
      return "Password must be more than 8";
    } else if (value != state.passwordController.text) {
      return "Password confirm doesn't match";
    }
    return null;
  }
}
