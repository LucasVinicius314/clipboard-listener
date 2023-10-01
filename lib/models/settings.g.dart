// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      playSoundEffect: json['playSoundEffect'] as bool,
      showSnackbar: json['showSnackbar'] as bool,
      volume: (json['volume'] as num).toDouble(),
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'playSoundEffect': instance.playSoundEffect,
      'showSnackbar': instance.showSnackbar,
      'volume': instance.volume,
    };
