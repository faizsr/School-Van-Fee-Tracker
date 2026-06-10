import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/add_edit_student_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/student_detail/student_detail_screen.dart';

// ─────────────────────────────────────────────
//  Route Names
// ─────────────────────────────────────────────

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String studentDetail = '/student-detail';
  static const String addStudent = '/add-student';
  static const String editStudent = '/edit-student';
  static const String settings = '/settings';
}

// ─────────────────────────────────────────────
//  Route Generator
// ─────────────────────────────────────────────

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ── Home ──────────────────────────────
      case AppRoutes.home:
        return _buildRoute(const HomeScreen());

      // ── Student Detail ────────────────────
      case AppRoutes.studentDetail:
        return _buildRoute(StudentDetailScreen());

      // ── Add Student ───────────────────────
      case AppRoutes.addStudent:
        return _buildRoute(const AddEditStudentScreen());

      // // ── Edit Student ──────────────────────
      // case AppRoutes.editStudent:
      //   final student = settings.arguments as Student;
      //   return _buildRoute(AddEditStudentScreen(student: student));

      // // ── Settings ──────────────────────────
      // case AppRoutes.settings:
      //   return _buildRoute(const SettingsScreen());

      // ── Unknown Route ─────────────────────
      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
