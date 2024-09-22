import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:scrapwala_dev/core/remote_config/remote_config_service.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/gen/assets.gen.dart';

class MaintenancePage extends ConsumerWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(
          onPressed: () {
            const HomeRoute().go(context);
          },
          child: const Text('Refresh'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _handleRefresh(ref),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false, // Prevent default scrolling behavior
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Assets.lottie.appUnderMaintainence,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'We\'re under maintenance!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      '  We\'re currently working on some improvements and will be back soon. Please check back later.   ',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh(WidgetRef ref) async {
    RemoteConfigService.fetchAndSettle();
    ref.invalidate(remoteConfigUpdateProvider);
  }
}
