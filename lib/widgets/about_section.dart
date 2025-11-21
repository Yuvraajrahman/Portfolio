import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/constants.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? AppConstants.horizontalPaddingMobile
              : AppConstants.horizontalPadding,
          vertical: isMobile
              ? AppConstants.sectionSpacingMobile
              : AppConstants.sectionSpacing,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: AnimatedSlide(
                    offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '03.',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w300,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'About Me',
                          style: isMobile
                              ? AppTextStyles.sectionTitleMobile
                              : AppTextStyles.sectionTitle,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 2,
                          width: isMobile ? 100 : 150,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Content
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: AnimatedSlide(
                    offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                    duration: const Duration(milliseconds: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Introduction
                        Text(
                          'Hello! I\'m Bokhtiar Rahman Juboraz, a passionate Computer Science student '
                          'at BRAC University with diverse experience in web design & development, '
                          'AI and machine learning projects, PC games development, designing UX/UI with '
                          'full fledge system analysis, and experience in digital marketing.',
                          style: AppTextStyles.body.copyWith(
                            fontSize: isMobile ? 14 : 16,
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          'My journey in technology has led me to explore various domains:',
                          style: AppTextStyles.body.copyWith(
                            fontSize: isMobile ? 14 : 16,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Experience Points
                        _buildExperiencePoint(
                          '🚀 Full Stack Development',
                          'Building sophisticated web applications using Flutter, MERN stack, '
                          'with focus on user experience and scalable architecture',
                          isMobile,
                        ),

                        _buildExperiencePoint(
                          '⛓️ Blockchain Technology',
                          'Developing decentralized applications with Solidity, smart contracts, '
                          'and cryptocurrency integration for secure and transparent systems',
                          isMobile,
                        ),

                        _buildExperiencePoint(
                          '🎮 Game Development',
                          'Creating engaging gaming experiences with Python/Pygame and Unreal Engine, '
                          'focusing on creative gameplay mechanics',
                          isMobile,
                        ),

                        _buildExperiencePoint(
                          '👨‍💼 Leadership Experience',
                          'Serving as Director of HR and Admin at BRAC University Entrepreneurship '
                          'Development Forum, managing 1200+ members and organizing major events',
                          isMobile,
                        ),

                        _buildExperiencePoint(
                          '🔬 Research & Development',
                          'Participating in collaborative research projects, contributing to data '
                          'analysis, technical documentation, and software development',
                          isMobile,
                        ),

                        const SizedBox(height: 32),

                        // Education
                        Container(
                          padding: EdgeInsets.all(isMobile ? 24 : 32),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            border: Border.all(
                              color: AppColors.borderColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '🎓',
                                    style: TextStyle(fontSize: 32),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'B.Sc. in Computer Science',
                                          style: TextStyle(
                                            fontSize: isMobile ? 18 : 20,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'BRAC University',
                                          style: TextStyle(
                                            fontSize: isMobile ? 14 : 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '2020 - 2025',
                                          style: TextStyle(
                                            fontSize: isMobile ? 12 : 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Current Focus
                        Text(
                          'Currently, I\'m seeking opportunities to further develop my technical '
                          'skills and contribute to innovative projects that make a real impact. '
                          'I\'m particularly interested in full-stack development roles where I can '
                          'leverage my diverse skill set.',
                          style: AppTextStyles.body.copyWith(
                            fontSize: isMobile ? 14 : 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExperiencePoint(String title, String description, bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTextStyles.body.copyWith(
              fontSize: isMobile ? 13 : 15,
            ),
          ),
        ],
      ),
    );
  }
}

