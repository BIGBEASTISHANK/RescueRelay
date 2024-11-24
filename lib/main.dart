import 'package:flutter/material.dart';
import 'package:rescuerelay/data/data.dart';
import 'package:rescuerelay/components/Common/Sidebar.dart';
import 'package:rescuerelay/components/VolunteerPanel/VolunteerHome.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Material Apps
    return MaterialApp(
        home: Scaffold(
      // Appbar
      appBar: AppBar(
        // Basic Formatting
        title: const Text("Rescue Relay"),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0XFF0088CC),

        // Menu button
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
          },
        ),

        // Other Action Button
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),

      // Drawer
      drawer: const SideBar(),

      // Styling
      backgroundColor: const Color(0XFF1A1E23),

      // Main body
      body: currentAccountType == accountTypes.hosts
          ? const Placeholder()
          : const VolunteerHome(),
    ));
  }
}
