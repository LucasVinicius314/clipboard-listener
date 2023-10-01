import 'package:clipboard_listener/repositories/settings_repository.dart';
import 'package:clipboard_listener/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesService = SharedPreferencesService();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SettingsRepository(
            sharedPreferencesService: sharedPreferencesService,
          ),
        ),
      ],
      child: child,
    );
  }
}
