// Events.

import 'package:clipboard_listener/models/settings.dart';
import 'package:clipboard_listener/repositories/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SettingsEvent {}

class GetSettingsEvent extends SettingsEvent {}

class SaveSettingsEvent extends SettingsEvent {
  SaveSettingsEvent({
    required this.settings,
  });

  final Settings? settings;
}

// States.

abstract class SettingsState {}

class SettingsLoadingState extends SettingsState {}

// GetSettings.

class GetSettingsDoneState extends SettingsState {
  GetSettingsDoneState({
    required this.settings,
  });

  final Settings? settings;
}

class GetSettingsErrorState extends SettingsState {}

// SaveSettings.

class SaveSettingsDoneState extends SettingsState {}

class SaveSettingsErrorState extends SettingsState {}

// Bloc.

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.settingsRepository,
  }) : super(SettingsLoadingState()) {
    on<GetSettingsEvent>((event, emit) async {
      try {
        emit(SettingsLoadingState());

        final res = await settingsRepository.get();

        emit(GetSettingsDoneState(settings: res));
      } catch (e) {
        emit(GetSettingsErrorState());
      }
    });

    on<SaveSettingsEvent>((event, emit) async {
      try {
        emit(SettingsLoadingState());

        await settingsRepository.set(settings: event.settings);

        emit(SaveSettingsDoneState());
      } catch (e) {
        emit(SaveSettingsErrorState());
      }
    });
  }

  final SettingsRepository settingsRepository;
}
