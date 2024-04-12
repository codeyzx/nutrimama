import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/input_form/dropdown_form_widget.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/question/question_controller.dart';
import 'package:nutrimama/src/shared/extensions/dynamic.dart';

class QuestionDropDownForm extends ConsumerWidget {
  const QuestionDropDownForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionControllerProvider);
    final controller = ref.read(questionControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //DropdownFormWidget(
        //  value: state.gender,
        //  list: const [
        //    {'value': 'Male', 'text': 'Male'},
        //    {'value': 'Female', 'text': 'Female'},
        //  ],
        //  prefixIcon: Icons.wc,
        //  onChanged: (value) {
        //    if (value.isNotNull()) {
        //      controller.setGender(value.toString());
        //    }
        //  },
        //),
        //Gap.h12,
        DropdownFormWidget(
          value: state.age,
          list: state.ageList,
          prefixIcon: Icons.looks_one,
          onChanged: (value) {
            if (value.isNotNull()) {
              controller.setAge(value.toString());
            }
          },
        ),
        Gap.h12,
      ],
    );
  }
}
