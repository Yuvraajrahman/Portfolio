import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isScrolled = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80,
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.surface.withValues(alpha: 0.8)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled
                ? AppColors.borderColor
                : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? AppConstants.horizontalPaddingMobile
              : AppConstants.horizontalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Text(
                'BRJ',
                style: TextStyle(
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
            ),

            // Navigation Items
            if (!isMobile)
              Row(
                children: [
                  _buildNavItem('Home', 0),
                  _buildNavItem('Projects', 1),
                  _buildNavItem('AI/ML', 2),
                  _buildNavItem('Skills', 3),
                  _buildNavItem('About', 4),
                  _buildNavItem('Contact', 5),
                ],
              )
            else
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.primary),
                onPressed: () => _showMobileMenu(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    final isSelected = widget.selectedIndex == index;
    final delay = index * 100;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => widget.onItemSelected(index),
            borderRadius: BorderRadius.circular(8),
            splashColor: AppColors.primary.withValues(alpha: 0.2),
            highlightColor: AppColors.primary.withValues(alpha: 0.1),
            hoverColor: AppColors.primary.withValues(alpha: 0.05),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.secondary,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 2,
                      width: isSelected ? 20 : 0,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavItem('Home', 0, context),
            _buildMobileNavItem('Projects', 1, context),
            _buildMobileNavItem('AI/ML', 2, context),
            _buildMobileNavItem('Skills', 3, context),
            _buildMobileNavItem('About', 4, context),
            _buildMobileNavItem('Contact', 5, context),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String title, int index, BuildContext context) {
    final isSelected = widget.selectedIndex == index;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onItemSelected(index);
          Navigator.pop(context);
        },
        splashColor: AppColors.primary.withValues(alpha: 0.2),
        highlightColor: AppColors.primary.withValues(alpha: 0.1),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primary : AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

