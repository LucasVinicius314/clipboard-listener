import 'package:flutter/material.dart';

class VolumeSliderController extends ChangeNotifier {
  var _value = 0.0;

  double get() {
    return _value;
  }

  void set(double value) {
    _value = value;

    notifyListeners();
  }
}

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final VolumeSliderController controller;
  final void Function(double value)? onChanged;

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  var _value = 0.0;

  @override
  void initState() {
    super.initState();

    _value = widget.controller.get();

    widget.controller.addListener(() {
      setState(() {
        _value = widget.controller.get();
      });
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Slider(
            value: _value,
            onChangeEnd: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onChanged: widget.onChanged == null
                ? null
                : (value) {
                    widget.controller.set(value);
                  },
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '${(_value * 100).toStringAsFixed(0)} %',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
