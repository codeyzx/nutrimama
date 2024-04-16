import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<bool?> registerValue;
  final bool isObscure;
  final bool isObscureConfirm;
  final Map<String, dynamic>? errors;
  final String roleValue;
  final List<Map<String, String>> roles;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  RegisterState({
    this.registerValue = const AsyncData(null),
    this.isObscure = true,
    this.isObscureConfirm = true,
    this.errors,
    this.roleValue = 'USER',
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
  }) : roles = [
          {
            'text': 'User',
            'value': 'USER',
          },
          {
            'text': 'Event Organizer',
            'value': 'EO',
          },
        ];

  bool get isLoading => registerValue.isLoading;

  RegisterState copyWith({
    AsyncValue<bool>? registerValue,
    bool? isObscure,
    bool? isObscureConfirm,
    Map<String, dynamic>? errors,
    String? roleValue,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? passwordConfirmController,
  }) {
    return RegisterState(
      registerValue: registerValue ?? this.registerValue,
      isObscure: isObscure ?? this.isObscure,
      isObscureConfirm: isObscureConfirm ?? this.isObscureConfirm,
      errors: errors ?? this.errors,
      roleValue: roleValue ?? this.roleValue,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      passwordConfirmController:
          passwordConfirmController ?? this.passwordConfirmController,
    );
  }
}
