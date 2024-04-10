import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/data/auth_repository.dart';
import 'package:nutrimama/src/features/auth/domain/request_login.dart';
import 'package:nutrimama/src/features/auth/presentation/login/login_state.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() {
    return LoginState(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  Future<void> login() async {
    final authRepository = ref.read(authRepositoryProvider);
    if (!state.formKey.currentState!.validate()) {
      return;
    }

    state = state.copyWith(
      loginValue: const AsyncLoading(),
    );

    final requestLogin = RequestLogin(
      email: state.emailController.text,
      password: state.passwordController.text,
    );

    final result = await authRepository.login(requestLogin);

    result.when(
      success: (data) async {
        state = state.copyWith(
          loginValue: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          loginValue: AsyncError(error, stackTrace),
        );
      },
    );
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

  void onObscureTap() {
    state = state.copyWith(
      isObscure: !state.isObscure,
    );
  }
}
