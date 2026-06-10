import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/core/router/app_routes.dart';
import 'package:school_van_fee_tracker/src/screens/home/widgets/k_search_field.dart';
import 'package:school_van_fee_tracker/src/screens/home/widgets/student_card.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          Expanded(
            child: ListView.separated(
              itemCount: 20,
              itemBuilder: (context, index) => StudentCard(),
              separatorBuilder: (context, index) => separator,
            ),
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
          KIconButton(icon: AppIcons.download, iconSize: 20, onPressed: () {}),
          hSpace12,
          KIconButton(icon: AppIcons.settings, iconSize: 20, onPressed: () {}),
          hSpace12,
          KIconButton(
            icon: AppIcons.userAdd,
            iconSize: 20,
            iconColor: AppColors.white,
            bgColor: AppColors.blue,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addStudent);
            },
          ),
        ],
      ),
    );
  }
}
