import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:willy_o/core/components/app_button.dart';
import 'package:willy_o/core/components/app_text_field.dart';
import 'package:willy_o/core/constants/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() =>
      setState(() => _obscurePassword = !_obscurePassword);

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.kBackgroundDark,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _LoginHeader(),
                  const SizedBox(height: 48),
                  _LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    obscurePassword: _obscurePassword,
                    onTogglePassword: _togglePasswordVisibility,
                  ),
                  const SizedBox(height: 32),
                  AppButton(text: 'Entrar', onPressed: _handleLogin),
                  const SizedBox(height: 16),
                  _ForgotPasswordLink(),
                  const SizedBox(height: 48),
                  _RegisterLink(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Image.asset(
            'assets/images/Kino_pirate_skull_with_eye_patch.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 24),
          const Text(
            'Bem-vindo, Pirata!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Entre para encontrar seus tesouros',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.kTextSecondary,
            ),
          ),
        ],
      );
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AppTextField(
            controller: emailController,
            label: 'E-mail',
            hint: 'seu@email.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: _validateEmail,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: passwordController,
            label: 'Senha',
            obscureText: obscurePassword,
            prefixIcon: Icons.lock_outlined,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.kPrimaryColor,
              ),
              onPressed: onTogglePassword,
            ),
            validator: _validatePassword,
          ),
        ],
      );

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe seu e-mail';
    if (!value.contains('@')) return 'E-mail inválido';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Informe sua senha';
    if (value.length < 6) return 'Senha deve ter ao menos 6 caracteres';
    return null;
  }
}

class _ForgotPasswordLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () {},
        child: const Text(
          'Esqueceu sua senha?',
          style: TextStyle(color: AppColors.kPrimaryColor),
        ),
      );
}

class _RegisterLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Não tem uma conta? ',
            style: TextStyle(color: AppColors.kTextSecondary),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Cadastre-se',
              style: TextStyle(
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
