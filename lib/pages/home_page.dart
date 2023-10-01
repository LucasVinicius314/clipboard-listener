import 'package:audioplayers/audioplayers.dart';
import 'package:clipboard_listener/blocs/settings_bloc.dart';
import 'package:clipboard_listener/models/settings.dart';
import 'package:clipboard_listener/utils/assets.dart';
import 'package:clipboard_listener/utils/constants.dart';
import 'package:clipboard_listener/utils/utils.dart';
import 'package:clipboard_listener/widgets/switch_expansion_tile.dart';
import 'package:clipboard_listener/widgets/clipboard_listener.dart';
import 'package:clipboard_listener/widgets/volume_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _playSoundEffect = false;
  var _showSnackbar = false;

  final _volumeSliderController = VolumeSliderController();

  final _audioPlayer = AudioPlayer();

  // TODO: fix, theme change

  Widget _getSettingsCard() {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is GetSettingsDoneState) {
          if (state.settings != null) {
            _loadSettings(settings: state.settings!);
          }
        } else if (state is SaveSettingsDoneState) {
          BlocProvider.of<SettingsBloc>(context).add(GetSettingsEvent());
        } else if (state is SaveSettingsErrorState) {
          Utils.showSnackbar(context, content: 'Failed to save settings.');
        }
      },
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Builder(
                  builder: (context) {
                    if (state is GetSettingsErrorState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Failed to load settings.'),
                      );
                    }

                    if (state is GetSettingsDoneState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          _getSnackbarTile(),
                          const SizedBox(height: 16),
                          _getSoundEffectTile(),
                        ],
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getSnackbarTile() {
    return SwitchExpansionTile(
      onChanged: (value) {
        setState(() {
          _showSnackbar = value;
        });

        _saveSettings();
      },
      title: 'Show snackbar',
      value: _showSnackbar,
      child: null,
    );
  }

  Widget _getSoundEffectTile() {
    return SwitchExpansionTile(
      onChanged: (value) {
        setState(() {
          _playSoundEffect = value;
        });

        _saveSettings();
      },
      title: 'Play sound effect',
      value: _playSoundEffect,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Text(
              'Volume',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: VolumeSlider(
              controller: _volumeSliderController,
              onChanged: (value) async {
                await _audioPlayer.setVolume(value);

                _saveSettings();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadSettings({
    required Settings settings,
  }) {
    setState(() {
      _playSoundEffect = settings.playSoundEffect;
      _showSnackbar = settings.showSnackbar;
    });

    _volumeSliderController.set(settings.volume);
  }

  void _saveSettings() {
    BlocProvider.of<SettingsBloc>(context).add(
      SaveSettingsEvent(
        settings: Settings(
          playSoundEffect: _playSoundEffect,
          showSnackbar: _showSnackbar,
          volume: _volumeSliderController.get(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SettingsBloc>(context).add(GetSettingsEvent());
  }

  @override
  void dispose() {
    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
      ),
      body: ClipboardWatcher(
        onClipboardChanged: (clipboardData) async {
          if (_playSoundEffect) {
            await _audioPlayer.play(AssetSource(Assets.ping));
          }

          if (_showSnackbar && mounted) {
            Utils.showSnackbar(context, content: 'Clipboard changed.');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _getSettingsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
