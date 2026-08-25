import 'package:flutter/material.dart';

class TouchWorld extends StatefulWidget {
  final Widget child;
  const TouchWorld({super.key, required this.child});

  @override
  State<TouchWorld> createState() => _TouchWorldState();
}

class _TouchWorldState extends State<TouchWorld> {
  Offset _pointer = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) => setState(() => _pointer = event.localPosition),
      onPointerUp: (_) => setState(() => _pointer = Offset.zero),
      child: Stack(
        children: [
          widget.child,
          IgnorePointer(
            child: AnimatedPositioned(
              duration: const Duration(milliseconds: 80),
              left: _pointer == Offset.zero ? -40 : _pointer.dx - 14,
              top: _pointer == Offset.zero ? -40 : _pointer.dy - 14,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 120),
                opacity: _pointer == Offset.zero ? 0 : 0.22,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
