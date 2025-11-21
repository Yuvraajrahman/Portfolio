import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/skill.dart';
import '../utils/constants.dart';

class CombinedExpertiseSection extends StatefulWidget {
  const CombinedExpertiseSection({super.key});

  @override
  State<CombinedExpertiseSection> createState() => _CombinedExpertiseSectionState();
}

class _CombinedExpertiseSectionState extends State<CombinedExpertiseSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> services = [
    {
      'icon': '🌐',
      'title': 'Web Development',
      'description': 'Full-stack web applications using Flutter, React, and MERN stack.',
      'tags': ['Flutter Web', 'React', 'Node.js', 'MongoDB'],
    },
    {
      'icon': '📱',
      'title': 'Mobile Development',
      'description': 'Cross-platform mobile apps with Flutter for iOS and Android.',
      'tags': ['Flutter', 'iOS', 'Android', 'Firebase'],
    },
    {
      'icon': '⛓️',
      'title': 'Blockchain Development',
      'description': 'Smart contracts and DApps with Solidity and Web3.',
      'tags': ['Solidity', 'Web3', 'Smart Contracts', 'DApps'],
    },
    {
      'icon': '🤖',
      'title': 'AI & Machine Learning',
      'description': 'ML models, data analysis, and AI-powered solutions.',
      'tags': ['Python', 'TensorFlow', 'ML Models', 'Data Science'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1200;
    final skills = SkillsData.getAllSkills();

    return VisibilityDetector(
      key: const Key('combined-expertise-section'),
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
          vertical: isMobile ? 40 : 50,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expertise & Skills',
                        style: isMobile
                            ? AppTextStyles.sectionTitleMobile
                            : AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What I Do & Technologies I Master',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        ),
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

                const SizedBox(height: 32),

                // Services and Skills Side by Side
                if (!isMobile)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Services Column
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Services',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...services.asMap().entries.map((entry) {
                              return _buildCompactServiceCard(
                                entry.value,
                                entry.key,
                              );
                            }),
                          ],
                        ),
                      ),

                      const SizedBox(width: 32),

                      // Skills Column
                      Expanded(
                        flex: isTablet ? 1 : 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Technical Skills',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildCompactSkillsGrid(skills, false),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  // Mobile layout - stacked
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...services.asMap().entries.map((entry) {
                        return _buildCompactServiceCard(
                          entry.value,
                          entry.key,
                        );
                      }),
                      const SizedBox(height: 32),
                      Text(
                        'Technical Skills',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCompactSkillsGrid(skills, true),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactServiceCard(Map<String, dynamic> service, int index) {
    final delay = index * 100;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 800 + delay),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
                Text(
                  service['icon'],
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    service['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              service['description'],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: (service['tags'] as List<String>).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactSkillsGrid(List<Skill> skills, bool isMobile) {
    return Column(
      children: skills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        final delay = index * 100;

        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 800 + delay),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
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
                    Text(
                      skill.icon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        skill.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skill.items.map((item) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

