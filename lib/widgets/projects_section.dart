import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/project.dart';
import '../utils/constants.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final projects = ProjectsData.getAllProjects();
    final categories = ProjectsData.getCategories();

    final filteredProjects = _selectedCategory == 'All'
        ? projects
        : projects
            .where((project) => project.category == _selectedCategory)
            .toList();

    return VisibilityDetector(
      key: const Key('projects-section'),
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
                          '01.',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w300,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Featured Projects',
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
                                  : AppColors.cardBackground,
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

                // Projects Grid
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _buildProjectsGrid(filteredProjects, isMobile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(List<Project> projects, bool isMobile) {
    return Column(
      children: List.generate(projects.length, (index) {
        return _buildProjectCard(
          projects[index],
          index,
          isMobile,
        );
      }),
    );
  }

  Widget _buildProjectCard(Project project, int index, bool isMobile) {
    final delay = index * 100;
    
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 800 + delay),
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.3),
        duration: Duration(milliseconds: 800 + delay),
        child: Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: _ProjectCard(
                project: project,
                isMobile: isMobile,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isMobile;

  const _ProjectCard({
    required this.project,
    required this.isMobile,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: Container(
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
              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  border: Border.all(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.project.category,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                    letterSpacing: 1,
                  ),
                ),
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
                        color: AppColors.borderColor,
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
      ),
    );
  }
}

