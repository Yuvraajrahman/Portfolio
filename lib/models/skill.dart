class Skill {
  final String name;
  final List<String> items;
  final String icon;

  Skill({
    required this.name,
    required this.items,
    required this.icon,
  });
}

class SkillsData {
  static List<Skill> getAllSkills() {
    return [
      Skill(
        name: 'Frontend Development',
        icon: '💻',
        items: [
          'Flutter & Dart',
          'React.js',
          'JavaScript',
          'HTML5 & CSS3',
        ],
      ),
      Skill(
        name: 'Backend Development',
        icon: '⚙️',
        items: [
          'Node.js',
          'Express.js',
          'MongoDB',
          'Firebase',
        ],
      ),
      Skill(
        name: 'Blockchain & Web3',
        icon: '🔗',
        items: [
          'Solidity',
          'Smart Contracts',
          'Metamask Integration',
          'Cryptocurrency Systems',
        ],
      ),
      Skill(
        name: 'Game Development',
        icon: '🎮',
        items: [
          'Python & Pygame',
          'Unreal Engine Blueprints',
          'Game Mechanics Design',
          'User Experience Design',
        ],
      ),
      Skill(
        name: 'Deployment & DevOps',
        icon: '🚀',
        items: [
          'Vercel',
          'Firebase Hosting',
          'Linux (Debian, Arch)',
          'Local & Remote Deployment',
        ],
      ),
      Skill(
        name: 'Database & Systems',
        icon: '🗄️',
        items: [
          'MongoDB',
          'Firebase Firestore',
          'SQL Basics',
          'Database Architecture',
        ],
      ),
      Skill(
        name: 'Programming Languages',
        icon: '📝',
        items: [
          'Dart',
          'JavaScript',
          'Python',
          'C (Compiler Development)',
        ],
      ),
      Skill(
        name: 'Languages',
        icon: '🌐',
        items: [
          'Bengali (Fluent)',
          'English (Fluent)',
          'Hindi (Fluent)',
          'Japanese (Intermediate)',
        ],
      ),
    ];
  }
}

