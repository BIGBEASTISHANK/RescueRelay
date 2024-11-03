import 'package:flutter/material.dart';
import 'package:rescuerelay/components/Sidebar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      // Appbar
      appBar: AppBar(
        // Basic Formatting
        title: const Text("Rescue Relay"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,

        // Menu button
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu));
        }),

        // Other Action Button
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search),
          )
        ],
      ),

      // Drawer
      drawer: const SideBar(),
    ));
  }
}
