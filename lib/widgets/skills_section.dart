import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/skill.dart';
import '../utils/constants.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final skills = SkillsData.getAllSkills();

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        width: double.infinity,
        color: AppColors.surface,
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
                          '02.',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w300,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Skills & Expertise',
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

                // Skills Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = isMobile
                        ? 1
                        : (constraints.maxWidth > 900 ? 3 : 2);
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: isMobile ? 1.5 : 1.2,
                      ),
                      itemCount: skills.length,
                      itemBuilder: (context, index) {
                        return _buildSkillCard(skills[index], index, isMobile);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(Skill skill, int index, bool isMobile) {
    final delay = index * 100;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 800 + delay),
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.3),
        duration: Duration(milliseconds: 800 + delay),
        child: _SkillCard(
          skill: skill,
          isMobile: isMobile,
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Skill skill;
  final bool isMobile;

  const _SkillCard({
    required this.skill,
    required this.isMobile,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        padding: EdgeInsets.all(widget.isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon
            Text(
              widget.skill.icon,
              style: TextStyle(
                fontSize: widget.isMobile ? 32 : 40,
              ),
            ),

            const SizedBox(height: 16),

            // Skill Name
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: widget.isMobile ? 16 : 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 16),

            // Skill Items
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.skill.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 8),
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: widget.isMobile ? 12 : 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

