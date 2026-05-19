import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class FloatingCubes extends StatefulWidget {
  const FloatingCubes({super.key, this.dense = false});

  final bool dense;

  @override
  State<FloatingCubes> createState() => _FloatingCubesState();
}

class _FloatingCubesState extends State<FloatingCubes>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _cubes = [
    _CubeSpec(x: 0.08, y: 0.12, size: 76, phase: 0.2, tilt: -0.24),
    _CubeSpec(x: 0.83, y: 0.15, size: 96, phase: 1.8, tilt: 0.2),
    _CubeSpec(x: 0.12, y: 0.74, size: 62, phase: 2.6, tilt: 0.36),
    _CubeSpec(x: 0.79, y: 0.68, size: 70, phase: 4.1, tilt: -0.18),
    _CubeSpec(x: 0.47, y: 0.08, size: 52, phase: 5.2, tilt: 0.12),
    _CubeSpec(x: 0.92, y: 0.45, size: 46, phase: 3.4, tilt: 0.28),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = Responsive.isMobile(context);
            final isTablet = Responsive.isTablet(context);
            final visibleCount = isMobile ? 3 : (isTablet ? 5 : _cubes.length);
            final sizeScale = isMobile ? 0.66 : (isTablet ? 0.82 : 1.0);

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final time = _controller.value * math.pi * 2;
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;

                return Stack(
                  children: [
                    for (final spec in _cubes.take(visibleCount))
                      _FloatingCube(
                        spec: spec,
                        time: time,
                        width: width,
                        height: height,
                        sizeScale: sizeScale,
                        dense: widget.dense,
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _FloatingCube extends StatelessWidget {
  const _FloatingCube({
    required this.spec,
    required this.time,
    required this.width,
    required this.height,
    required this.sizeScale,
    required this.dense,
  });

  final _CubeSpec spec;
  final double time;
  final double width;
  final double height;
  final double sizeScale;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final cubeSize = spec.size * sizeScale * (dense ? 1.04 : 1.0);
    final verticalFloat = math.sin(time * 0.72 + spec.phase) * 18;
    final horizontalFloat = math.cos(time * 0.42 + spec.phase) * 10;
    final left = (spec.x * width + horizontalFloat)
        .clamp(10.0, math.max(10.0, width - cubeSize - 10))
        .toDouble();
    final top = (spec.y * height + verticalFloat)
        .clamp(14.0, math.max(14.0, height - cubeSize - 14))
        .toDouble();
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0016)
      ..rotateX(math.sin(time * 0.36 + spec.phase) * 0.34)
      ..rotateY(math.cos(time * 0.32 + spec.phase) * 0.36 + spec.tilt)
      ..rotateZ(math.sin(time * 0.24 + spec.phase) * 0.12);

    return Positioned(
      left: left,
      top: top,
      width: cubeSize,
      height: cubeSize,
      child: Opacity(
        opacity: dense ? 0.88 : 0.74,
        child: Transform(
          alignment: Alignment.center,
          transform: transform,
          child: CustomPaint(
            painter: _CubePainter(),
            size: Size.square(cubeSize),
          ),
        ),
      ),
    );
  }
}

class _CubeSpec {
  const _CubeSpec({
    required this.x,
    required this.y,
    required this.size,
    required this.phase,
    required this.tilt,
  });

  final double x;
  final double y;
  final double size;
  final double phase;
  final double tilt;
}

class _CubePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final edge = size.shortestSide * 0.7;
    final depth = size.shortestSide * 0.22;
    final origin = Offset(size.width * 0.16, size.height * 0.24);
    final front = Rect.fromLTWH(origin.dx, origin.dy + depth * 0.55, edge, edge);
    final shift = Offset(depth, -depth * 0.76);

    final frontPath = Path()..addRect(front);
    final topPath = Path()
      ..moveTo(front.left, front.top)
      ..lineTo(front.left + shift.dx, front.top + shift.dy)
      ..lineTo(front.right + shift.dx, front.top + shift.dy)
      ..lineTo(front.right, front.top)
      ..close();
    final sidePath = Path()
      ..moveTo(front.right, front.top)
      ..lineTo(front.right + shift.dx, front.top + shift.dy)
      ..lineTo(front.right + shift.dx, front.bottom + shift.dy)
      ..lineTo(front.right, front.bottom)
      ..close();

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.36)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.55, size.height * 0.86),
        width: size.width * 0.64,
        height: size.height * 0.14,
      ),
      shadowPaint,
    );

    final fillPaint = Paint()..style = PaintingStyle.fill;
    canvas.drawPath(
      topPath,
      fillPaint..color = Colors.white.withValues(alpha: 0.2),
    );
    canvas.drawPath(
      sidePath,
      fillPaint..color = Colors.white.withValues(alpha: 0.13),
    );
    canvas.drawPath(
      frontPath,
      fillPaint..color = Colors.white.withValues(alpha: 0.08),
    );

    final edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.78);

    canvas
      ..drawPath(frontPath, edgePaint)
      ..drawPath(topPath, edgePaint)
      ..drawPath(sidePath, edgePaint)
      ..drawLine(front.topLeft, front.topLeft + shift, edgePaint)
      ..drawLine(front.bottomRight, front.bottomRight + shift, edgePaint);
  }

  @override
  bool shouldRepaint(covariant _CubePainter oldDelegate) => false;
}
