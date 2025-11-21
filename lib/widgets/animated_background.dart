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
  final List<StarParticle> _particles = [];
  final List<ClickRipple> _ripples = [];
  Offset? _mousePosition;
  late AnimationController _spawnController;
  late AnimationController _rippleController;
  final math.Random _random = math.Random();
  
  @override
  void initState() {
    super.initState();
    
    // Controller that ticks every frame to update particles
    _spawnController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Start spawning particles
    _startParticleSpawning();
  }

  void _startParticleSpawning() {
    // Spawn new particles periodically
    _spawnController.addListener(() {
      // Spawn a new particle every ~150-300ms (randomized)
      if (_random.nextDouble() < 0.15) { // 15% chance per frame at 60fps = ~9 per second
        _spawnNewParticle();
      }
      
      // Remove expired particles (older than 2 seconds)
      _particles.removeWhere((particle) {
        final age = DateTime.now().difference(particle.spawnTime).inMilliseconds;
        return age > 2000;
      });
    });
  }

  void _spawnNewParticle() {
    // Spawn mostly from sides (left/right), less in middle
    double x;
    final sideChance = _random.nextDouble();
    
    if (sideChance < 0.75) {
      // 75% chance: spawn from left or right sides (0-25% or 75-100%)
      if (_random.nextBool()) {
        x = 0.05 + _random.nextDouble() * 0.25; // Left side (5-30%)
      } else {
        x = 0.70 + _random.nextDouble() * 0.25; // Right side (70-95%)
      }
    } else {
      // 25% chance: spawn in middle section (25-75%)
      x = 0.30 + _random.nextDouble() * 0.40; // Middle (30-70%)
    }
    
    setState(() {
      _particles.add(StarParticle(
        x: x,
        y: 0.1 + _random.nextDouble() * 0.8, // 10-90% of height
        size: 6.0 + _random.nextDouble() * 18, // 6-24px
        baseOpacity: 0.2 + _random.nextDouble() * 0.3, // 0.2-0.5
        spawnTime: DateTime.now(),
      ));
    });
  }


  void _onPointerMove(PointerEvent event) {
    setState(() {
      _mousePosition = event.localPosition;
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
    _spawnController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base background
        Container(
          color: const Color(0xFF000000),
        ),
        
          // Fixed background particles (don't scroll)
          Positioned.fill(
            child: Listener(
              onPointerMove: _onPointerMove,
              onPointerDown: _onPointerDown,
              child: AnimatedBuilder(
                animation: Listenable.merge([_spawnController, _rippleController]),
                builder: (context, child) {
                  return CustomPaint(
                    painter: StarParticlePainter(
                      particles: _particles,
                      ripples: _ripples,
                      mousePosition: _mousePosition,
                      rippleValue: _rippleController.value,
                    ),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),
        
        // Scrollable content
        widget.child,
      ],
    );
  }
}

class StarParticle {
  final double x; // 0-1 (percentage of width)
  final double y; // 0-1 (percentage of height)
  final double size;
  final double baseOpacity;
  final DateTime spawnTime;

  StarParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.baseOpacity,
    required this.spawnTime,
  });
  
  // Calculate opacity based on age (star-like fade in/out over 2 seconds)
  double getOpacity() {
    final age = DateTime.now().difference(spawnTime).inMilliseconds;
    final progress = (age / 2000.0).clamp(0.0, 1.0);
    
    // Fade in first 25%, stay visible 50%, fade out last 25%
    double fadeMultiplier;
    if (progress < 0.25) {
      // Fade in (0 to 0.25 seconds = 0 to 500ms)
      fadeMultiplier = progress / 0.25;
    } else if (progress < 0.75) {
      // Stay at full opacity (0.25 to 0.75 = 500ms to 1500ms)
      fadeMultiplier = 1.0;
    } else {
      // Fade out (0.75 to 1.0 = 1500ms to 2000ms)
      fadeMultiplier = 1.0 - ((progress - 0.75) / 0.25);
    }
    
    // Add subtle twinkle effect
    final twinkle = 0.8 + (math.sin(age / 200.0) * 0.2);
    
    return baseOpacity * fadeMultiplier * twinkle;
  }
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

class StarParticlePainter extends CustomPainter {
  final List<StarParticle> particles;
  final List<ClickRipple> ripples;
  final Offset? mousePosition;
  final double rippleValue;

  StarParticlePainter({
    required this.particles,
    required this.ripples,
    required this.mousePosition,
    required this.rippleValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw each particle as a twinkling star
    for (final particle in particles) {
      final particleX = particle.x * size.width;
      final particleY = particle.y * size.height;

      // Get animated opacity with twinkle effect
      double opacity = particle.getOpacity();

      // Calculate distance from mouse
      double scale = 1.0;

      if (mousePosition != null) {
        final dx = particleX - mousePosition!.dx;
        final dy = particleY - mousePosition!.dy;
        final distance = math.sqrt(dx * dx + dy * dy);
        const maxDistance = 200.0; // Influence radius

        if (distance < maxDistance) {
          // Zoom in 20% when near mouse
          final influence = 1 - (distance / maxDistance);
          scale = 1.0 + (influence * 0.2);
          opacity = (opacity + (influence * 0.2)).clamp(0.0, 1.0);
        }
      }

      // Draw square outline (star)
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
    
    // Draw cursor tracking effect
    if (mousePosition != null) {
      _drawCursorEffect(canvas, size, paint);
    }

    // Draw click ripples
    for (final ripple in ripples) {
      final age = DateTime.now().difference(ripple.timestamp).inMilliseconds;
      final progress = (age / 800.0).clamp(0.0, 1.0);
      
      if (progress < 1.0) {
        // Expanding square ripple
        final rippleOpacity = (1 - progress) * 0.6;
        
        // Draw multiple expanding squares
        for (int i = 0; i < 3; i++) {
          final delay = i * 0.15;
          final delayedProgress = (progress - delay).clamp(0.0, 1.0);
          
          if (delayedProgress > 0) {
            final rippleSize = 10 + (delayedProgress * (60 + i * 20));
            final opacity = (1 - delayedProgress) * rippleOpacity * (1 - i * 0.3);
            
            paint.color = Color.fromRGBO(255, 255, 255, opacity);
            paint.strokeWidth = 2.0 - (i * 0.5);
            
            final rect = Rect.fromCenter(
              center: Offset(ripple.x, ripple.y),
              width: rippleSize,
              height: rippleSize,
            );
            
            canvas.drawRect(rect, paint);
          }
        }
      }
    }
  }

  double _easeInOutCubic(double t) {
    if (t < 0.5) {
      return 4 * t * t * t;
    } else {
      return 1 - math.pow(-2 * t + 2, 3) / 2;
    }
  }

  void _drawCursorEffect(Canvas canvas, Size size, Paint paint) {
    if (mousePosition == null) return;
    
    // Minimalistic cursor follower - small square outline
    paint.color = const Color(0x40FFFFFF); // 25% opacity
    paint.strokeWidth = 1.0;
    
    // Small square following cursor
    final cursorRect = Rect.fromCenter(
      center: mousePosition!,
      width: 12,
      height: 12,
    );
    canvas.drawRect(cursorRect, paint);
    
    // Even smaller inner square
    paint.color = const Color(0x20FFFFFF); // 12.5% opacity
    final innerRect = Rect.fromCenter(
      center: mousePosition!,
      width: 6,
      height: 6,
    );
    canvas.drawRect(innerRect, paint);
  }

  @override
  bool shouldRepaint(covariant StarParticlePainter oldDelegate) {
    return true; // Always repaint for smooth animations
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

