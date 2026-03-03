import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:willy_o/core/theme/app_theme.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Willy-O')),
      ),
    ),
  ],
);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        title: 'Willy-O',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      );
}
