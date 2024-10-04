import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  const Hover({
    super.key,
    required this.builder,
  });

  final Widget Function(bool hover) builder;

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      child: widget.builder(_isHovered),
    );
  }
}
