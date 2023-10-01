import 'package:flutter/material.dart';

class SwitchExpansionTile extends StatefulWidget {
  const SwitchExpansionTile({
    super.key,
    required this.onChanged,
    required this.title,
    required this.value,
    required this.child,
  });

  final void Function(bool value)? onChanged;
  final String title;
  final bool value;
  final Widget? child;

  @override
  State<SwitchExpansionTile> createState() => _SwitchExpansionTileState();
}

class _SwitchExpansionTileState extends State<SwitchExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.only(left: 16, right: 8),
            onChanged: widget.onChanged == null
                ? null
                : (value) {
                    widget.onChanged!(value);
                  },
            title: Text(widget.title),
            value: widget.value,
          ),
          if (widget.child != null && widget.value) widget.child!,
        ],
      ),
    );
  }
}
