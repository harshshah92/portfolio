class ProjectModel {
  final String id;
  final String title;
  final String subtitle;
  final String domain;
  final String overview;
  final List<String> techStack;
  final List<String> features;
  final List<String> architectureHighlights;
  final List<String> technicalChallenges;
  final List<String> keyDeliverables;
  final List<String> screenshots;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.domain,
    required this.overview,
    required this.techStack,
    required this.features,
    required this.architectureHighlights,
    required this.technicalChallenges,
    required this.keyDeliverables,
    this.screenshots = const [],
    this.isFeatured = false,
  });
}
