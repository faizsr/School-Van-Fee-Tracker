import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/router/app_routes.dart';
import 'package:school_van_fee_tracker/src/providers/school_provider.dart';
import 'package:school_van_fee_tracker/src/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SchoolProvider()),
      ],
      child: MaterialApp(
        title: 'School Van Fee Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'SF-Pro'),
        home: const HomeScreen(),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
