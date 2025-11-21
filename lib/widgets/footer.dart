import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? AppConstants.horizontalPaddingMobile
            : AppConstants.horizontalPadding,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
          child: Column(
            children: [
              // Logo
              Text(
                'BRJ',
                style: TextStyle(
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 24),

              // Tagline
              Text(
                'Full Stack Developer | Flutter Enthusiast | Blockchain Developer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 32),

              // Divider
              Container(
                height: 1,
                color: AppColors.borderColor,
              ),

              const SizedBox(height: 32),

              // Copyright and Credits
              Column(
                children: [
                  Text(
                    '© 2025 Bokhtiar Rahman Juboraz',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Designed & Built with Flutter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 10 : 12,
                      fontWeight: FontWeight.w300,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Back to top
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    // Scroll to top will be handled by the parent
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

