import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Widget child;

  const LoadingScreen({
    super.key,
    required this.child,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  double _loadingProgress = 0.0;
  bool _isLoaded = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Simulate loading progress
    _simulateLoading();
  }

  void _simulateLoading() {
    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        // Simulate realistic loading curve
        if (_loadingProgress < 0.3) {
          _loadingProgress += 0.02; // Fast start
        } else if (_loadingProgress < 0.7) {
          _loadingProgress += 0.015; // Medium
        } else if (_loadingProgress < 0.95) {
          _loadingProgress += 0.01; // Slow down
        } else {
          _loadingProgress += 0.005; // Very slow at end
        }

        if (_loadingProgress >= 1.0) {
          _loadingProgress = 1.0;
          timer.cancel();
          
          // Wait a bit at 100%, then fade out
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              _fadeController.forward().then((_) {
                if (mounted) {
                  setState(() {
                    _isLoaded = true;
                  });
                }
              });
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded) {
      return widget.child;
    }

    return Stack(
      children: [
        // The actual content (hidden but loading)
        Opacity(
          opacity: 0,
          child: widget.child,
        ),

        // Loading overlay
        AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                color: const Color(0xFF000000),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated loading squares
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CustomPaint(
                          painter: LoadingSquaresPainter(
                            progress: _loadingProgress,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Loading percentage
                      Text(
                        '${(_loadingProgress * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 4,
                          decoration: TextDecoration.none,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Loading text
                      Text(
                        'Loading Portfolio',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                          decoration: TextDecoration.none,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Progress bar
                      Container(
                        width: 200,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _loadingProgress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class LoadingSquaresPainter extends CustomPainter {
  final double progress;

  LoadingSquaresPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.white;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw 3 rotating squares
    for (int i = 0; i < 3; i++) {
      final squareSize = 30.0 + (i * 20);
      final rotation = (progress * 6.28318) + (i * 1.047); // 2π and π/3
      final opacity = 0.3 + (i * 0.2);

      paint.color = Colors.white.withValues(alpha: opacity);

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotation * (i % 2 == 0 ? 1 : -1));

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: squareSize,
        height: squareSize,
      );

      canvas.drawRect(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant LoadingSquaresPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

