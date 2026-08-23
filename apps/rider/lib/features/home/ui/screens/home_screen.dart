import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasal/features/auth/ui/providers/logout/logout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.homeTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.l10n.welcomeMessage, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                ref.watch(logoutProvider);
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary500,
                    foregroundColor: context.colors.neutral200,
                    fixedSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await ref.read(logoutProvider.notifier).execute();

                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.auth,
                      (route) => false,
                    );
                  },
                  child: ref
                      .watch(logoutProvider)
                      .when(
                        data: (isLoggedOut) => Text(context.l10n.logout),
                        loading: () => CircularProgressIndicator(
                          color: context.colors.neutral200,
                        ),
                        error: (error, stackTrace) =>
                            Text(context.l10n.logoutFailed),
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
