import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/question/question_controller.dart';

class QuestionInputForm extends ConsumerWidget {
  const QuestionInputForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionControllerProvider);
    final controller = ref.read(questionControllerProvider.notifier);

    return Form(
        key: state.formKey,
        child: Column(
          children: [
            InputFormWidget(
              controller: state.weightController,
              onChanged: (value) {},
              hintText: 'Weight',
              prefixIcon: Icons.monitor_weight,
              validator: controller.validateWeight,
              isWeight: true,
            ),
            Gap.h12,
            InputFormWidget(
              controller: state.heightController,
              onChanged: (value) {},
              hintText: 'Height',
              prefixIcon: Icons.leaderboard,
              validator: controller.validateHeight,
              isHeight: true,
            ),
          ],
        ));
  }
}
