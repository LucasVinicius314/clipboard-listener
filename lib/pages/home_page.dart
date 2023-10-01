import 'package:audioplayers/audioplayers.dart';
import 'package:clipboard_listener/utils/constants.dart';
import 'package:clipboard_listener/widgets/switch_expansion_tile.dart';
import 'package:clipboard_listener/widgets/clipboard_listener.dart';
import 'package:clipboard_listener/widgets/volume_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _playAudioCue = false;
  var _showSnackbar = false;

  final _audioPlayer = AudioPlayer();

  // TODO: fix, theme change

  // TODO: fix, load settings

  void _saveSettings() {
    // TODO: fix, save settings
  }

  @override
  void initState() {
    super.initState();

    _audioPlayer.setSourceAsset('audio/cue.mp3');
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
          if (_showSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('New content copied.')),
            );
          }

          if (_playAudioCue) {
            await _audioPlayer.play(AssetSource('audio/cue.mp3'));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      SwitchExpansionTile(
                        onChanged: (value) {
                          setState(() {
                            _playAudioCue = value;
                          });

                          _saveSettings();
                        },
                        title: 'Play audio cue',
                        value: _playAudioCue,
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
                                onChanged: (value) async {
                                  await _audioPlayer.setVolume(value);

                                  _saveSettings();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SwitchExpansionTile(
                        onChanged: (value) {
                          setState(() {
                            _showSnackbar = value;
                          });

                          _saveSettings();
                        },
                        title: 'Show snackbar',
                        value: _showSnackbar,
                        child: null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
