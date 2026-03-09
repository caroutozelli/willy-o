import 'package:flutter/material.dart';
import 'package:willy_o/core/constants/app_colors.dart';

class TreasureValue extends StatelessWidget {
  const TreasureValue({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) => Text(
        value,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.kPrimaryColor,
          shadows: [
            Shadow(
              color: AppColors.kOverlay,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
      );
}
