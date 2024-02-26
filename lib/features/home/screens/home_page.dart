import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: const Text("Authenticated User"),
        onPressed: () {
          controller.signOut();
        },
      )),
    );
  }
}
