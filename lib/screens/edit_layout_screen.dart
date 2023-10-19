import 'package:flutter/material.dart';
import 'package:flutter_filemaker_desktop/providers/selected_layout_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditLayoutScreen extends ConsumerStatefulWidget {
  const EditLayoutScreen({super.key});

  @override
  ConsumerState<EditLayoutScreen> createState() => _EditLayoutScreenState();
}

class _EditLayoutScreenState extends ConsumerState<EditLayoutScreen> {
  Offset position = const Offset(100, 100);
  double prevScale = 1;
  double scale = 1;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);
  void commitScale() => setState(() => prevScale = scale);
  void updatePosition(Offset newPosition) =>
      setState(() => position = newPosition);

  @override
  void initState() {
    // getLayoutWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (details) => updateScale(details.scale),
      onScaleEnd: (_) => commitScale(),
      child: Stack(children: [
        Positioned.fill(
          child: Container(
            color: Colors.amber.withOpacity(.4),
          ),
        ),
        Positioned(
          left: position.dx,
          top: position.dy,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: Container(color: Colors.blue, height: 10, width: 10),
            childWhenDragging: Opacity(
              opacity: .3,
              child: Container(color: Colors.blue, height: 10, width: 10),
            ),
            onDragEnd: (details) => updatePosition(details.offset),
            child: Transform.scale(
              scale: scale,
              child: Container(color: Colors.blue, height: 100, width: 100),
            ),
          ),
        ),
      ]),
    );
  }
}
