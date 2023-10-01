import 'package:clipboard_listener/blocs/settings_bloc.dart';
import 'package:clipboard_listener/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsBloc(
            settingsRepository:
                RepositoryProvider.of<SettingsRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
