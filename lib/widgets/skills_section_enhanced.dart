import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/skill.dart';
import '../utils/constants.dart';

class SkillsSectionEnhanced extends StatefulWidget {
  const SkillsSectionEnhanced({super.key});

  @override
  State<SkillsSectionEnhanced> createState() => _SkillsSectionEnhancedState();
}

class _SkillsSectionEnhancedState extends State<SkillsSectionEnhanced> {
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
                        childAspectRatio: isMobile ? 1.2 : 1.0,
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
        child: _SkillCardEnhanced(
          skill: skill,
          isMobile: isMobile,
          isVisible: _isVisible,
        ),
      ),
    );
  }
}

class _SkillCardEnhanced extends StatefulWidget {
  final Skill skill;
  final bool isMobile;
  final bool isVisible;

  const _SkillCardEnhanced({
    required this.skill,
    required this.isMobile,
    required this.isVisible,
  });

  @override
  State<_SkillCardEnhanced> createState() => _SkillCardEnhancedState();
}

class _SkillCardEnhancedState extends State<_SkillCardEnhanced>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    if (widget.isVisible) {
      _progressController.forward();
    }
  }

  @override
  void didUpdateWidget(_SkillCardEnhanced oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _progressController.forward();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

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
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: _isHovered
                      ? AppColors.primary
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                widget.skill.icon,
                style: TextStyle(
                  fontSize: widget.isMobile ? 32 : 40,
                ),
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

            // Skill Items with progress
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.skill.items.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final item = entry.value;
                    final delay = idx * 0.15;
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item,
                            style: TextStyle(
                              fontSize: widget.isMobile ? 12 : 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedBuilder(
                            animation: _progressController,
                            builder: (context, child) {
                              final value = ((_progressController.value - delay) * 1.3)
                                  .clamp(0.0, 1.0);
                              
                              return Stack(
                                children: [
                                  Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: value * 0.7 + 0.3, // 30%-100%
                                    child: Container(
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primary,
                                            AppColors.primary.withOpacity(0.6),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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

