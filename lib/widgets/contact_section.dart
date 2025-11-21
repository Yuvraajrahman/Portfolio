import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'bokhtiar.rahman.juboraz@g.bracu.ac.bd',
      query: 'subject=Hello%20from%20Portfolio',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+8801957631102',
    );
    
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('contact-section'),
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
                          '04.',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w300,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Get In Touch',
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
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          children: [
                            Text(
                              'I\'m currently looking for new opportunities and my inbox is always open. '
                              'Whether you have a question, want to collaborate on a project, or just '
                              'want to say hi, I\'ll try my best to get back to you!',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body.copyWith(
                                fontSize: isMobile ? 14 : 16,
                              ),
                            ),

                            const SizedBox(height: 48),

                            // Contact Cards
                            if (!isMobile)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildContactCard(
                                      icon: Icons.email_outlined,
                                      title: 'Email',
                                      subtitle: 'bokhtiar.rahman.juboraz@g.bracu.ac.bd',
                                      onTap: _launchEmail,
                                      isMobile: false,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: _buildContactCard(
                                      icon: Icons.phone_outlined,
                                      title: 'Phone',
                                      subtitle: '+880 1957631102',
                                      onTap: _launchPhone,
                                      isMobile: false,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  _buildContactCard(
                                    icon: Icons.email_outlined,
                                    title: 'Email',
                                    subtitle: 'bokhtiar.rahman.juboraz@g.bracu.ac.bd',
                                    onTap: _launchEmail,
                                    isMobile: true,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildContactCard(
                                    icon: Icons.phone_outlined,
                                    title: 'Phone',
                                    subtitle: '+880 1957631102',
                                    onTap: _launchPhone,
                                    isMobile: true,
                                  ),
                                ],
                              ),

                            const SizedBox(height: 32),

                            // Location
                            _buildContactCard(
                              icon: Icons.location_on_outlined,
                              title: 'Location',
                              subtitle: 'Badda, Dhaka, Bangladesh',
                              onTap: null,
                              isMobile: isMobile,
                            ),

                            const SizedBox(height: 48),

                            // CTA Button
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: ElevatedButton(
                                onPressed: _launchEmail,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.background,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 40 : 60,
                                    vertical: isMobile ? 16 : 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Text(
                                  'SAY HELLO',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    required bool isMobile,
  }) {
    return _ContactCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      isMobile: isMobile,
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isMobile;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.onTap != null ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.onTap != null ? (_) => setState(() => _isHovered = false) : null,
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          padding: EdgeInsets.all(widget.isMobile ? 20 : 24),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.borderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: AppColors.primary,
                size: widget.isMobile ? 24 : 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 14 : 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 12 : 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

