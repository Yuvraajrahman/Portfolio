import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class SocialLinks extends StatelessWidget {
  final bool isVertical;
  final bool isMobile;

  const SocialLinks({
    super.key,
    this.isVertical = true,
    required this.isMobile,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final socialLinks = [
      {
        'icon': Icons.code,
        'label': 'GitHub',
        'url': 'https://github.com/yourusername', // Update with your GitHub
      },
      {
        'icon': Icons.work,
        'label': 'LinkedIn',
        'url': 'https://linkedin.com/in/yourusername', // Update with your LinkedIn
      },
      {
        'icon': Icons.email,
        'label': 'Email',
        'url': 'mailto:bokhtiar.rahman.juboraz@g.bracu.ac.bd',
      },
    ];

    if (isMobile) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: socialLinks.map((link) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildSocialIcon(link),
          );
        }).toList(),
      );
    }

    return Column(
      children: socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildSocialIcon(link),
        );
      }).toList(),
    );
  }

  Widget _buildSocialIcon(Map<String, dynamic> link) {
    return _SocialIconButton(
      icon: link['icon'] as IconData,
      label: link['label'] as String,
      onTap: () => _launchURL(link['url'] as String),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary
                : AppColors.cardBackground,
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.borderColor,
              width: 1,
            ),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? AppColors.background : AppColors.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}

