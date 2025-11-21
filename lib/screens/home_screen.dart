import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/statistics_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/ml_projects_section.dart';
import '../widgets/combined_expertise_section.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/animated_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AutoScrollController _scrollController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Update selected index based on scroll position
    final position = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    
    if (position < maxScroll * 0.15) {
      if (_selectedIndex != 0) setState(() => _selectedIndex = 0);
    } else if (position < maxScroll * 0.4) {
      if (_selectedIndex != 1) setState(() => _selectedIndex = 1);
    } else if (position < maxScroll * 0.65) {
      if (_selectedIndex != 2) setState(() => _selectedIndex = 2);
    } else if (position < maxScroll * 0.85) {
      if (_selectedIndex != 3) setState(() => _selectedIndex = 3);
    } else {
      if (_selectedIndex != 4) setState(() => _selectedIndex = 4);
    }
  }

  void _scrollToSection(int index) {
    _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(0),
                  controller: _scrollController,
                  index: 0,
                  child: const HeroSection(),
                ),
              ),
              const SliverToBoxAdapter(
                child: StatisticsSection(),
              ),
              const SliverToBoxAdapter(
                child: CombinedExpertiseSection(),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(1),
                  controller: _scrollController,
                  index: 1,
                  child: const ProjectsSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(2),
                  controller: _scrollController,
                  index: 2,
                  child: const MLProjectsSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(3),
                  controller: _scrollController,
                  index: 3,
                  child: const AboutSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScrollTag(
                  key: const ValueKey(4),
                  controller: _scrollController,
                  index: 4,
                  child: const ContactSection(),
                ),
              ),
              const SliverToBoxAdapter(
                child: Footer(),
              ),
              ],
            ),
            CustomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemSelected: _scrollToSection,
            ),
          ],
        ),
      ),
    );
  }
}

