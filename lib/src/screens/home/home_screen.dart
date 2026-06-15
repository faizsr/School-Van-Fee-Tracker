import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/core/router/app_routes.dart';
import 'package:school_van_fee_tracker/src/providers/school_provider.dart';
import 'package:school_van_fee_tracker/src/providers/student_provider.dart';
import 'package:school_van_fee_tracker/src/screens/home/widgets/k_search_field.dart';
import 'package:school_van_fee_tracker/src/screens/home/widgets/student_card.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SchoolProvider schoolProvider;
  late StudentProvider studentProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schoolProvider = context.read<SchoolProvider>();
      studentProvider = context.read<StudentProvider>();
      schoolProvider.getSchools();
      studentProvider.getStudents();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Column(
        spacing: 4,
        children: [
          buildHomeAppbar(context),
          separator,
          KSearchField(),
          Consumer<StudentProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.gray,
                      strokeWidth: 1.5,
                    ),
                  ),
                );
              }

              if (value.students.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No students found',
                      style: TextStyle(color: AppColors.gray),
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: value.students.length,
                  separatorBuilder: (context, index) => separator,
                  itemBuilder: (context, index) =>
                      StudentCard(student: value.students[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding buildHomeAppbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fee Tracker',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'For School Van',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          Spacer(),
          // KIconButton(icon: AppIcons.download, iconSize: 20, onPressed: () {}),
          // hSpace12,
          KIconButton(
            icon: AppIcons.settings,
            iconSize: 20,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
          hSpace12,
          KIconButton(
            icon: AppIcons.userAdd,
            iconSize: 20,
            iconColor: AppColors.white,
            bgColor: AppColors.blue,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.addStudent,
                arguments: {'type': PageType.add},
              );
            },
          ),
        ],
      ),
    );
  }
}
