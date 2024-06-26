import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

class DropdownWidget<T> extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T? value)? onChanged;
  const DropdownWidget({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorApp.grey,
        hintText: hintText,
        hintStyle: TypographyApp.text1.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      isEmpty: value == null || value == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          items: items,
          onChanged: onChanged,
          isDense: true,
          style: TypographyApp.text1,
          value: value,
        ),
      ),
    );
  }
}
