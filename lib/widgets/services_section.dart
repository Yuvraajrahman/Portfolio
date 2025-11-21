import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/constants.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> services = [
    {
      'icon': '🌐',
      'title': 'Web Development',
      'description':
          'Full-stack web applications using Flutter, React, and MERN stack with modern UI/UX design.',
      'tags': ['Flutter Web', 'React', 'Node.js', 'MongoDB'],
    },
    {
      'icon': '📱',
      'title': 'Mobile Development',
      'description':
          'Cross-platform mobile apps with Flutter delivering native performance and beautiful interfaces.',
      'tags': ['Flutter', 'iOS', 'Android', 'Firebase'],
    },
    {
      'icon': '⛓️',
      'title': 'Blockchain Development',
      'description':
          'Smart contracts and decentralized applications with Solidity and cryptocurrency integration.',
      'tags': ['Solidity', 'Web3', 'Smart Contracts', 'DApps'],
    },
    {
      'icon': '🤖',
      'title': 'AI & Machine Learning',
      'description':
          'Machine learning models, data analysis, and AI-powered solutions for real-world problems.',
      'tags': ['Python', 'TensorFlow', 'ML Models', 'Data Science'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('services-section'),
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
                          'What I Do',
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

                // Services Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = isMobile
                        ? 1
                        : (constraints.maxWidth > 900 ? 2 : 1);
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: isMobile ? 1.1 : 1.5,
                      ),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return _buildServiceCard(
                          services[index],
                          index,
                          isMobile,
                        );
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

  Widget _buildServiceCard(
    Map<String, dynamic> service,
    int index,
    bool isMobile,
  ) {
    final delay = index * 100;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 800 + delay),
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.3),
        duration: Duration(milliseconds: 800 + delay),
        child: _ServiceCard(
          service: service,
          isMobile: isMobile,
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final Map<String, dynamic> service;
  final bool isMobile;

  const _ServiceCard({
    required this.service,
    required this.isMobile,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
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
            // Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.accent,
                border: Border.all(
                  color: _isHovered ? AppColors.primary : AppColors.borderColor,
                  width: 1,
                ),
              ),
              child: Text(
                widget.service['icon'],
                style: TextStyle(
                  fontSize: widget.isMobile ? 32 : 40,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              widget.service['title'],
              style: TextStyle(
                fontSize: widget.isMobile ? 20 : 24,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 12),

            // Description
            Expanded(
              child: Text(
                widget.service['description'],
                style: TextStyle(
                  fontSize: widget.isMobile ? 13 : 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (widget.service['tags'] as List<String>).map((tag) {
                return Container(
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
                    tag,
                    style: const TextStyle(
                      fontSize: 11,
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
}

