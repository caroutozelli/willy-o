import 'package:flutter/material.dart';
import 'package:willy_o/core/constants/app_colors.dart';
import 'package:willy_o/features/home/presentation/components/treasure_card.dart';
import 'package:willy_o/features/home/presentation/components/treasure_value.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: AppColors.kBackgroundDark,
        body: _HomeContent(),
      );
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          _BackgroundImage(),
          _ContentOverlay(),
        ],
      );
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D4A3E),
              Color(0xFF1A2F26),
              AppColors.kBackgroundDark,
            ],
          ),
        ),
      );
}

class _ContentOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _NavigationArrows(),
            const SizedBox(height: 24),
            const TreasureValue(value: r'R$ 20,00'),
            const Spacer(),
            const TreasureCard(),
            const SizedBox(height: 24),
            _WillyOLogo(),
            const SizedBox(height: 40),
          ],
        ),
      );
}

class _NavigationArrows extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(
            Icons.keyboard_arrow_down,
            size: 48,
            color: AppColors.kPrimaryColor.withValues(alpha: 0.8),
          ),
          Transform.translate(
            offset: const Offset(0, -24),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 48,
              color: AppColors.kPrimaryColor.withValues(alpha: 0.5),
            ),
          ),
        ],
      );
}

class _WillyOLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.kSecondaryColor,
          border: Border.all(color: AppColors.kPrimaryColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Kino_pirate_skull_with_eye_patch.png',
              width: 40,
              height: 40,
            ),
            const Text(
              'WILLYO',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: AppColors.kPrimaryColor,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      );
}
