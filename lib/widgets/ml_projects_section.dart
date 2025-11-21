import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/ml_project.dart';
import '../utils/constants.dart';

class MLProjectsSection extends StatefulWidget {
  const MLProjectsSection({super.key});

  @override
  State<MLProjectsSection> createState() => _MLProjectsSectionState();
}

class _MLProjectsSectionState extends State<MLProjectsSection> {
  String _selectedCategory = 'All';
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final projects = MLProjectsData.getAllProjects();
    final categories = MLProjectsData.getCategories();

    final filteredProjects = _selectedCategory == 'All'
        ? projects
        : projects
            .where((project) => project.category == _selectedCategory)
            .toList();

    return VisibilityDetector(
      key: const Key('ml-projects-section'),
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
                        Row(
                          children: [
                            const Text(
                              '🤖',
                              style: TextStyle(fontSize: 48),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AI & ML Projects',
                                    style: isMobile
                                        ? AppTextStyles.sectionTitleMobile
                                        : AppTextStyles.sectionTitle,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Machine Learning & Artificial Intelligence',
                                    style: TextStyle(
                                      fontSize: isMobile ? 14 : 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 2,
                          width: isMobile ? 100 : 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primary.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Category Filter
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: categories.map((category) {
                      final isSelected = _selectedCategory == category;
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16 : 24,
                              vertical: isMobile ? 8 : 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.borderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? AppColors.background
                                    : AppColors.primary,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 48),

                // Projects or Placeholder
                if (filteredProjects.isEmpty)
                  _buildPlaceholder(isMobile)
                else
                  _buildProjectsGrid(filteredProjects, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(bool isMobile) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 32 : 48),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            const Text(
              '🚀',
              style: TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 24),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'AI & Machine Learning projects will be added here.\n'
              'Stay tuned for exciting ML models and data science projects!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(List<MLProject> projects, bool isMobile) {
    return Column(
      children: List.generate(projects.length, (index) {
        return _buildProjectCard(projects[index], index, isMobile);
      }),
    );
  }

  Widget _buildProjectCard(MLProject project, int index, bool isMobile) {
    final delay = index * 100;
    
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 800 + delay),
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.3),
        duration: Duration(milliseconds: 800 + delay),
        child: Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: _MLProjectCard(
            project: project,
            isMobile: isMobile,
          ),
        ),
      ),
    );
  }
}

class _MLProjectCard extends StatefulWidget {
  final MLProject project;
  final bool isMobile;

  const _MLProjectCard({
    required this.project,
    required this.isMobile,
  });

  @override
  State<_MLProjectCard> createState() => _MLProjectCardState();
}

class _MLProjectCardState extends State<_MLProjectCard> {
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
        padding: EdgeInsets.all(widget.isMobile ? 24 : 32),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with category and metrics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        '🤖 ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        widget.project.category,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                // Metrics
                if (widget.project.accuracy != null && !widget.isMobile)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Accuracy: ${widget.project.accuracy}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 24),

            // Project Name
            Text(
              widget.project.name,
              style: AppTextStyles.cardTitle.copyWith(
                fontSize: widget.isMobile ? 20 : 24,
              ),
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              widget.project.description,
              style: AppTextStyles.cardDescription,
            ),

            if (widget.project.dataset != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.dataset_outlined,
                    color: AppColors.secondary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.project.dataset!,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.secondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            // Highlights
            ...widget.project.highlights.map((highlight) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 12),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      highlight,
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            )),

            const SizedBox(height: 24),

            // Technologies
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.technologies.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tech,
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
  }
}

