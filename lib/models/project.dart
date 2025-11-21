class Project {
  final String name;
  final String description;
  final List<String> technologies;
  final String category;
  final List<String> highlights;

  Project({
    required this.name,
    required this.description,
    required this.technologies,
    required this.category,
    required this.highlights,
  });
}

class ProjectsData {
  static List<Project> getAllProjects() {
    return [
      Project(
        name: 'Clubhub',
        description: 'A comprehensive centralized app solution for 1200+ members of BUEDF club at BRAC University with sophisticated role system',
        technologies: ['Flutter', 'Firebase', 'Dart'],
        category: 'Web Application',
        highlights: [
          'Role-based access control system',
          'Communication management between university authorities',
          'Event management for 200+ young entrepreneurs',
          'Real-time notifications and updates',
        ],
      ),
      Project(
        name: 'Atsen',
        description: 'Fully furnished online platform for University providing sophisticated student-teacher online class room management',
        technologies: ['Flutter', 'Firebase', 'Dart'],
        category: 'Web Application',
        highlights: [
          'Integrated attendance management',
          'Live class scheduling and management',
          'Customizable member options',
          'Study content management system',
        ],
      ),
      Project(
        name: 'Medease',
        description: 'Blockchain-based medical platform with proper cryptocurrency exchange system for all types of users',
        technologies: ['Flutter', 'Solidity', 'Blockchain', 'Smart Contracts'],
        category: 'Web Application',
        highlights: [
          'Cryptocurrency payment integration',
          'Smart contract implementation',
          'Secure patient data management',
          'Admin, doctor, and patient role systems',
        ],
      ),
      Project(
        name: 'Sprint Submissions',
        description: 'Team-based sprint management system with role-based access and chain of command',
        technologies: ['MERN Stack', 'MongoDB', 'Express', 'React', 'Node.js'],
        category: 'Web Application',
        highlights: [
          'Sprint tracking and management',
          'Team collaboration features',
          'Role-based permissions',
          'Decision making workflow',
        ],
      ),
      Project(
        name: 'CurvySnake',
        description: 'Creative PC game with focus on user experience, gameplay mechanics, and creativity',
        technologies: ['Python', 'Pygame'],
        category: 'Game Development',
        highlights: [
          'Custom game mechanics',
          'Engaging user experience',
          'Original gameplay design',
          'Performance optimized',
        ],
      ),
      Project(
        name: 'User Feedback Analysis System',
        description: 'Advanced system with annotated graphs and charts from backend database to frontend UI',
        technologies: ['React', 'Node.js', 'MongoDB', 'Data Visualization'],
        category: 'Full Stack',
        highlights: [
          'Real-time data visualization',
          'Advanced analytics dashboard',
          'Performance metrics tracking',
          'Interactive charts and graphs',
        ],
      ),
    ];
  }

  static List<String> getCategories() {
    return [
      'All',
      'Web Application',
      'Game Development',
      'Full Stack',
    ];
  }
}

