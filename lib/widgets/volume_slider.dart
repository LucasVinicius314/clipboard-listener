import 'package:flutter/material.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({
    super.key,
    required this.onChanged,
  });

  final void Function(double value)? onChanged;

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  var _value = 0.0;

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
                    setState(() {
                      _value = value;
                    });
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
