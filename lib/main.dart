import 'package:flutter/material.dart';
import 'package:rescuerelay/data/data.dart';
import 'package:rescuerelay/components/Common/Sidebar.dart';
import 'package:rescuerelay/components/VolunteerPanel/VolunteerHome.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

class AppColors {
  static const Color primary = Color(0XFF0088CC);
  static const Color accent = Colors.lightBlueAccent;
  static const Color cardBackground = Color(0XFF0A0C0E);
  static const Color background = Color(0XFF1A1E23);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Enhanced AppBar with improved design
        appBar: AppBar(
          // Enhanced title with icon
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                ),
                child: const Icon(
                  Icons.emergency,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Text(
                "Rescue Relay",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          foregroundColor: Colors.white,
          elevation: 4,
          
          // Gradient background
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  Color(0xFF0066AA),
                ],
              ),
            ),
          ),

          // Enhanced menu button
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
                tooltip: 'Menu',
              );
            },
          ),

          // Enhanced action buttons
          actions: [
            IconButton(
              onPressed: () {
                // TODO: Implement search functionality
              },
              icon: const Icon(Icons.search),
              tooltip: 'Search',
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
        ),

        // Drawer
        drawer: const SideBar(),

        // Styling
        backgroundColor: AppColors.background,

        // Main body
        body: currentAccountType == accountTypes.hosts
            ? const Placeholder()
            : const VolunteerHome(),
      ),
    );
  }
}
