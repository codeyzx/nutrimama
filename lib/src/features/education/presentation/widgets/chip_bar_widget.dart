import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/constants/constants.dart';

class ChipBarWidget extends StatelessWidget {
  final String selectedChipIndex;
  final Function(String) onChipSelected;
  final List<Widget> chips;
  final List<String> enumValues;

  const ChipBarWidget({
    super.key,
    required this.selectedChipIndex,
    required this.onChipSelected,
    required this.chips,
    required this.enumValues,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: chips.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final chip = chips[index];
        return Container(
          margin: EdgeInsets.only(right: 8.w),
          child: FilterChip(
            color: selectedChipIndex == enumValues[index]
                ? MaterialStateProperty.all(ColorApp.primary)
                : MaterialStateProperty.all(Colors.grey[200]),
            showCheckmark: false,
            label: chip,
            labelStyle: TextStyle(
              color: selectedChipIndex == enumValues[index]
                  ? Colors.white
                  : Colors.black,
            ),
            selected: selectedChipIndex == enumValues[index],
            onSelected: (_) {
              onChipSelected(enumValues[index]);
            },
            side: BorderSide.none,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        );
      },
    );
  }
}
