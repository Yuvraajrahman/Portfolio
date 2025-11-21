import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/constants.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      height: isMobile ? size.height * 0.85 : size.height * 0.75,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            AppColors.surface,
            AppColors.background,
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? AppConstants.horizontalPaddingMobile
                : AppConstants.horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animated greeting
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    'Hi, I\'m',
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 28,
                      fontWeight: FontWeight.w300,
                      color: AppColors.secondary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),

              // Name with animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    'Bokhtiar Rahman\nJuboraz',
                    style: isMobile
                        ? AppTextStyles.heroTitleMobile
                        : AppTextStyles.heroTitle,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Animated typing text
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  children: [
                    Text(
                      'I\'m a ',
                      style: isMobile
                          ? AppTextStyles.heroSubtitleMobile
                          : AppTextStyles.heroSubtitle,
                    ),
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Full Stack Developer',
                          textStyle: isMobile
                              ? AppTextStyles.heroSubtitleMobile.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                )
                              : AppTextStyles.heroSubtitle.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Flutter Developer',
                          textStyle: isMobile
                              ? AppTextStyles.heroSubtitleMobile.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                )
                              : AppTextStyles.heroSubtitle.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'MERN Stack Developer',
                          textStyle: isMobile
                              ? AppTextStyles.heroSubtitleMobile.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                )
                              : AppTextStyles.heroSubtitle.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Blockchain Developer',
                          textStyle: isMobile
                              ? AppTextStyles.heroSubtitleMobile.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                )
                              : AppTextStyles.heroSubtitle.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Description
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? double.infinity : 600,
                    ),
                    child: Text(
                      'Computer Science student with expertise in web development, '
                      'blockchain technology, and game development. Passionate about '
                      'creating innovative solutions with modern technologies.',
                      style: AppTextStyles.body.copyWith(
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // CTA Button
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.background,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 32 : 48,
                            vertical: isMobile ? 16 : 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          'View Projects',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Scroll indicator
              const SizedBox(height: 80),
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildScrollIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return Center(
      child: Column(
        children: [
          const Text(
            'SCROLL',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 10 * value),
                child: Opacity(
                  opacity: 1 - value,
                  child: child,
                ),
              );
            },
            onEnd: () {
              if (mounted) {
                setState(() {});
              }
            },
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.secondary,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

