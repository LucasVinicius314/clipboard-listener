import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardWatcher extends StatefulWidget {
  const ClipboardWatcher({
    super.key,
    required this.onClipboardChanged,
    required this.child,
  });

  final Widget child;
  final void Function(ClipboardData? clipboardData) onClipboardChanged;

  @override
  State<ClipboardWatcher> createState() => _ClipboardWatcherState();
}

class _ClipboardWatcherState extends State<ClipboardWatcher>
    with ClipboardListener {
  @override
  void onClipboardChanged() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);

    widget.onClipboardChanged(clipboardData);
  }

  @override
  void initState() {
    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
    super.initState();
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    clipboardWatcher.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
