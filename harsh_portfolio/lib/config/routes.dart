import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/project_detail_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String projects = '/projects';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/');
    final path = uri.path;

    if (path == '/' || path.isEmpty) {
      return _buildRoute(const HomeScreen(), settings);
    }

    if (path == '/projects') {
      return _buildRoute(const ProjectsScreen(), settings);
    }

    if (path.startsWith('/projects/')) {
      final id = path.replaceFirst('/projects/', '');
      return _buildRoute(ProjectDetailScreen(projectId: id), settings);
    }

    return _buildRoute(const HomeScreen(), settings);
  }

  static MaterialPageRoute _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }
}
