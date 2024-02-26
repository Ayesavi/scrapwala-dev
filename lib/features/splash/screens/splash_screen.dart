import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authStateChangesProvider, (prev, next) {
      if (next.value?.session != null) {
        const HomeRoute().go(context);
      } else {
        const AuthRoute().go(context);
      }
    });

    return Scaffold(
      body: SizedBox.expand(
        child: Center(
            child: GestureDetector(
                onTap: () {
                  // const AuthRoute().go(context);
                },
                child: const Text("Loading..."))),
      ),
    );
  }
}
