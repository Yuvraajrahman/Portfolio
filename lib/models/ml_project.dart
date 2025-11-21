class MLProject {
  final String name;
  final String description;
  final List<String> technologies;
  final String category;
  final List<String> highlights;
  final String? accuracy;
  final String? dataset;

  MLProject({
    required this.name,
    required this.description,
    required this.technologies,
    required this.category,
    required this.highlights,
    this.accuracy,
    this.dataset,
  });
}

class MLProjectsData {
  static List<MLProject> getAllProjects() {
    return [
      // Add your ML projects here
      MLProject(
        name: 'Sample ML Project',
        description: 'Your machine learning project description',
        technologies: ['Python', 'TensorFlow', 'Keras', 'Pandas'],
        category: 'Machine Learning',
        highlights: [
          'Feature engineering and data preprocessing',
          'Model training and optimization',
          'Achieved high accuracy metrics',
        ],
        accuracy: '95%',
        dataset: 'Custom dataset with 10K+ samples',
      ),
      // Add more projects as you complete them
    ];
  }

  static List<String> getCategories() {
    return [
      'All',
      'Machine Learning',
      'Deep Learning',
      'Computer Vision',
      'NLP',
      'Data Science',
    ];
  }
}

