import 'package:flutter/material.dart';
import 'package:willy_o/core/constants/app_colors.dart';

class TreasureCard extends StatelessWidget {
  const TreasureCard({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          width: 200,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF8B7355),
                Color(0xFF6B5344),
                Color(0xFF4A3728),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
              color: AppColors.kPrimaryColor.withValues(alpha: 0.5),
              width: 3,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _TreasureIcon(),
              _TreasureLock(),
            ],
          ),
        ),
      );
}

class _TreasureIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Icon(
        Icons.inventory_2,
        size: 80,
        color: AppColors.kPrimaryColor,
      );
}

class _TreasureLock extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Positioned(
        bottom: 20,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.kSecondaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.kPrimaryColor),
          ),
          child: const Icon(
            Icons.lock,
            size: 24,
            color: AppColors.kPrimaryColor,
          ),
        ),
      );
}
