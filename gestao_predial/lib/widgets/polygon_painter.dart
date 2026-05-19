import 'dart:math' as math;

import 'package:flutter/material.dart';

class ParticleNode {
  const ParticleNode({
    required this.anchor,
    required this.drift,
    required this.radius,
    required this.phase,
    required this.speed,
    required this.opacity,
    required this.depth,
  });

  final Offset anchor;
  final Offset drift;
  final double radius;
  final double phase;
  final double speed;
  final double opacity;
  final double depth;

  Offset position(Size size, double time) {
    final dx =
        math.sin(time * speed + phase) * drift.dx +
        math.cos(time * 0.37 + phase * 0.8) * drift.dx * 0.42;
    final dy =
        math.cos(time * (speed * 0.82) + phase) * drift.dy +
        math.sin(time * 0.43 + phase * 1.18) * drift.dy * 0.38;

    return Offset(anchor.dx * size.width + dx, anchor.dy * size.height + dy);
  }
}

class BackgroundDot {
  const BackgroundDot({
    required this.anchor,
    required this.drift,
    required this.radius,
    required this.phase,
    required this.speed,
    required this.opacity,
  });

  final Offset anchor;
  final Offset drift;
  final double radius;
  final double phase;
  final double speed;
  final double opacity;

  Offset position(Size size, double time) {
    final dx = math.sin(time * speed + phase) * drift.dx;
    final dy = math.cos(time * speed * 0.72 + phase) * drift.dy;

    return Offset(anchor.dx * size.width + dx, anchor.dy * size.height + dy);
  }
}

class PolygonPainter extends CustomPainter {
  PolygonPainter({
    required this.animation,
    required this.nodes,
    required this.dots,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final List<ParticleNode> nodes;
  final List<BackgroundDot> dots;

  static const _red = Color(0xFFFF2B2B);

  @override
  void paint(Canvas canvas, Size size) {
    final time = animation.value * math.pi * 2;
    final nodePositions = <Offset>[];

    _paintWhiteDots(canvas, size, time);

    for (final node in nodes) {
      nodePositions.add(node.position(size, time));
    }

    _paintPolygonFills(canvas, nodePositions, size);
    _paintConnections(canvas, nodePositions, size);
    _paintNodes(canvas, nodePositions, time);
  }

  void _paintWhiteDots(Canvas canvas, Size size, double time) {
    final dotPaint = Paint()..style = PaintingStyle.fill;

    for (final dot in dots) {
      final pulse = 0.5 + math.sin(time * dot.speed * 1.8 + dot.phase) * 0.5;
      final alpha = (dot.opacity * (0.62 + pulse * 0.72)).clamp(0.05, 0.56);

      dotPaint.color = Colors.white.withValues(alpha: alpha.toDouble());
      canvas.drawCircle(dot.position(size, time), dot.radius, dotPaint);
    }
  }

  void _paintConnections(Canvas canvas, List<Offset> positions, Size size) {
    final connectionDistance = (size.shortestSide * 0.18)
        .clamp(86.0, 174.0)
        .toDouble();
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < positions.length; i++) {
      for (var j = i + 1; j < positions.length; j++) {
        final distance = (positions[i] - positions[j]).distance;

        if (distance > connectionDistance) {
          continue;
        }

        final strength = (1 - distance / connectionDistance).clamp(0.0, 1.0);
        linePaint
          ..color = _red.withValues(alpha: (strength * 0.34).toDouble())
          ..strokeWidth = 0.45 + strength * 1.05;

        canvas.drawLine(positions[i], positions[j], linePaint);
      }
    }
  }

  void _paintPolygonFills(Canvas canvas, List<Offset> positions, Size size) {
    final fillPaint = Paint()..style = PaintingStyle.fill;
    final maxPerimeter = (size.shortestSide * 0.55).clamp(260.0, 520.0);

    // Small translucent triangular fills sell the connected polygon effect
    // without adding a heavy mesh layer on every frame.
    for (var i = 0; i < positions.length - 14; i += 7) {
      final a = positions[i];
      final b = positions[i + 5];
      final c = positions[i + 13];
      final perimeter = (a - b).distance + (b - c).distance + (c - a).distance;

      if (perimeter > maxPerimeter) {
        continue;
      }

      final strength = (1 - perimeter / maxPerimeter).clamp(0.0, 1.0);
      fillPaint.color = _red.withValues(alpha: (strength * 0.045).toDouble());

      final path = Path()
        ..moveTo(a.dx, a.dy)
        ..lineTo(b.dx, b.dy)
        ..lineTo(c.dx, c.dy)
        ..close();

      canvas.drawPath(path, fillPaint);
    }
  }

  void _paintNodes(Canvas canvas, List<Offset> positions, double time) {
    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);
    final corePaint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final pulse = 0.5 + math.sin(time * 1.75 * node.speed + node.phase) * 0.5;
      final glowRadius = (node.radius * 2.7 + pulse * 2.2) * node.depth;
      final coreRadius = (node.radius * 0.62 + pulse * 0.72) * node.depth;

      glowPaint.color = _red.withValues(alpha: 0.14 * node.opacity);
      corePaint.color = Colors.white.withValues(alpha: 0.48 * node.opacity);

      canvas
        ..drawCircle(positions[i], glowRadius, glowPaint)
        ..drawCircle(positions[i], coreRadius, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant PolygonPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.nodes != nodes ||
        oldDelegate.dots != dots;
  }
}
