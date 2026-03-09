import 'package:flutter/material.dart';
import 'package:willy_o/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width ?? double.infinity,
        height: 56,
        child: isOutlined ? _outlinedButton : _elevatedButton,
      );

  Widget get _elevatedButton => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: _buttonChild,
      );

  Widget get _outlinedButton => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.kPrimaryColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _buttonChild,
      );

  Widget get _buttonChild => isLoading
      ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.kSecondaryColor,
          ),
        )
      : Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isOutlined ? AppColors.kPrimaryColor : null,
          ),
        );
}
