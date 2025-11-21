import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  final List<Particle> _particles = [];
  final List<ClickRipple> _ripples = [];
  Offset? _mousePosition;
  late AnimationController _fadeController;
  late AnimationController _rippleController;
  
  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize particles
    _initializeParticles();
    
    // Start animation loop
    _fadeController.repeat(reverse: false);
  }

  void _initializeParticles() {
    final random = math.Random();
    // Create 40-60 particles
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: 8.0 + random.nextDouble() * 20, // 8-28px
        opacity: 0.0,
        baseOpacity: 0.15 + random.nextDouble() * 0.25, // 0.15-0.4
      ));
    }
  }

  void _onPointerMove(PointerEvent event) {
    setState(() {
      _mousePosition = event.localPosition;
      _fadeController.forward(from: 0);
    });
  }

  void _onPointerDown(PointerEvent event) {
    setState(() {
      _ripples.add(ClickRipple(
        x: event.localPosition.dx,
        y: event.localPosition.dy,
        timestamp: DateTime.now(),
      ));
      
      // Remove old ripples
      _ripples.removeWhere((ripple) {
        final age = DateTime.now().difference(ripple.timestamp).inMilliseconds;
        return age > 800;
      });
    });
    
    _rippleController.forward(from: 0);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: _onPointerMove,
      onPointerDown: _onPointerDown,
      child: Stack(
        children: [
          // Base background
          Container(
            color: const Color(0xFF000000),
          ),
          
          // Interactive particles
          AnimatedBuilder(
            animation: Listenable.merge([_fadeController, _rippleController]),
            builder: (context, child) {
              return CustomPaint(
                painter: InteractiveParticlePainter(
                  particles: _particles,
                  ripples: _ripples,
                  mousePosition: _mousePosition,
                  fadeValue: _fadeController.value,
                  rippleValue: _rippleController.value,
                ),
                size: Size.infinite,
              );
            },
          ),
          
          // Content
          widget.child,
        ],
      ),
    );
  }
}

class Particle {
  final double x; // 0-1 (percentage of width)
  final double y; // 0-1 (percentage of height)
  final double size;
  double opacity;
  final double baseOpacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.baseOpacity,
  });
}

class ClickRipple {
  final double x;
  final double y;
  final DateTime timestamp;

  ClickRipple({
    required this.x,
    required this.y,
    required this.timestamp,
  });
}

class InteractiveParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final List<ClickRipple> ripples;
  final Offset? mousePosition;
  final double fadeValue;
  final double rippleValue;

  InteractiveParticlePainter({
    required this.particles,
    required this.ripples,
    required this.mousePosition,
    required this.fadeValue,
    required this.rippleValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw particles
    for (final particle in particles) {
      final particleX = particle.x * size.width;
      final particleY = particle.y * size.height;

      // Calculate distance from mouse
      double scale = 1.0;
      double opacity = particle.baseOpacity;

      if (mousePosition != null) {
        final dx = particleX - mousePosition!.dx;
        final dy = particleY - mousePosition!.dy;
        final distance = math.sqrt(dx * dx + dy * dy);
        final maxDistance = 200; // Influence radius

        if (distance < maxDistance) {
          // Zoom in 20% when near mouse
          final influence = 1 - (distance / maxDistance);
          scale = 1.0 + (influence * 0.2);
          opacity = particle.baseOpacity + (influence * 0.4);
          
          // Apply fade out effect
          opacity *= (1 - fadeValue);
        } else {
          // Far from mouse - fade out faster
          opacity *= (1 - fadeValue * 1.5).clamp(0.0, 1.0);
        }
      } else {
        // No mouse movement - fade out
        opacity *= (1 - fadeValue * 0.8);
      }

      // Draw square outline
      if (opacity > 0.01) {
        paint.color = Color.fromRGBO(255, 255, 255, opacity.clamp(0.0, 1.0));
        
        final scaledSize = particle.size * scale;
        final rect = Rect.fromCenter(
          center: Offset(particleX, particleY),
          width: scaledSize,
          height: scaledSize,
        );
        
        canvas.drawRect(rect, paint);
      }
    }

    // Draw click ripples
    for (final ripple in ripples) {
      final age = DateTime.now().difference(ripple.timestamp).inMilliseconds;
      final progress = (age / 800.0).clamp(0.0, 1.0);
      
      if (progress < 1.0) {
        // Expanding square ripple
        final rippleSize = 10 + (progress * 60); // Expand from 10 to 70
        final rippleOpacity = (1 - progress) * 0.6;
        
        // Draw multiple expanding squares
        for (int i = 0; i < 3; i++) {
          final delay = i * 0.15;
          final delayedProgress = (progress - delay).clamp(0.0, 1.0);
          
          if (delayedProgress > 0) {
            final size = 10 + (delayedProgress * (60 + i * 20));
            final opacity = (1 - delayedProgress) * rippleOpacity * (1 - i * 0.3);
            
            paint.color = Color.fromRGBO(255, 255, 255, opacity);
            paint.strokeWidth = 2.0 - (i * 0.5);
            
            final rect = Rect.fromCenter(
              center: Offset(ripple.x, ripple.y),
              width: size,
              height: size,
            );
            
            canvas.drawRect(rect, paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant InteractiveParticlePainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition ||
        oldDelegate.fadeValue != fadeValue ||
        oldDelegate.rippleValue != rippleValue ||
        oldDelegate.ripples.length != ripples.length;
  }
}

// Grid pattern overlay for subtle texture
class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x03FFFFFF)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 50.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

