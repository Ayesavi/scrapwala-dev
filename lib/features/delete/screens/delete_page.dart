import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeletePage extends ConsumerWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AppFilledButton(
          label: 'Delete User',
          onTap: () async {
            await Supabase.instance.client.rpc('delete_user');
            await ref.read(authControllerProvider).signOut();
            return;
          },
        ),
      ),
    );
  }
}
