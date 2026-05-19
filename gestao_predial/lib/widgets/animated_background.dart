import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'polygon_painter.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key, required this.child});

  final Widget child;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<ParticleNode> _nodes;
  late final List<BackgroundDot> _dots;

  @override
  void initState() {
    super.initState();
    _nodes = _createNodes();
    _dots = _createDots();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 26),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<ParticleNode> _createNodes() {
    final random = math.Random(1129);

    return List.generate(76, (index) {
      final depth = 0.62 + random.nextDouble() * 0.92;

      return ParticleNode(
        anchor: Offset(random.nextDouble(), random.nextDouble()),
        drift: Offset(
          (18 + random.nextDouble() * 58) * depth,
          (14 + random.nextDouble() * 52) * depth,
        ),
        radius: 1.15 + random.nextDouble() * 2.25,
        phase: random.nextDouble() * math.pi * 2,
        speed: 0.28 + random.nextDouble() * 0.88,
        opacity: 0.38 + random.nextDouble() * 0.52,
        depth: depth,
      );
    });
  }

  List<BackgroundDot> _createDots() {
    final random = math.Random(4821);

    return List.generate(130, (index) {
      return BackgroundDot(
        anchor: Offset(random.nextDouble(), random.nextDouble()),
        drift: Offset(
          4 + random.nextDouble() * 18,
          4 + random.nextDouble() * 18,
        ),
        radius: 0.65 + random.nextDouble() * 1.25,
        phase: random.nextDouble() * math.pi * 2,
        speed: 0.18 + random.nextDouble() * 0.5,
        opacity: 0.12 + random.nextDouble() * 0.34,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF050505),
                Color(0xFF111111),
                Color(0xFF050505),
              ],
              stops: [0, 0.52, 1],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.72, -0.62),
              radius: 1.05,
              colors: [
                const Color(0xFFFF2B2B).withValues(alpha: 0.15),
                Colors.transparent,
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.78, 0.84),
              radius: 1.15,
              colors: [
                const Color(0xFFFF2B2B).withValues(alpha: 0.08),
                Colors.transparent,
              ],
            ),
          ),
        ),
        RepaintBoundary(
          child: CustomPaint(
            painter: PolygonPainter(
              animation: _controller,
              nodes: _nodes,
              dots: _dots,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1.18,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.76),
              ],
              stops: const [0.55, 1],
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}
