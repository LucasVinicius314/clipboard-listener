import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Settings {
  Settings({
    required this.playSoundEffect,
    required this.showSnackbar,
    required this.volume,
  });

  bool playSoundEffect;
  bool showSnackbar;
  double volume;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
