import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        // Drawer heading
        Container(
          color: Colors.blue,
          child: const Padding(
            padding: EdgeInsets.only(top: 30, left: 15, bottom: 13),
            child: Text(
              "Rescue Relay",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),

        // Divider
        const Divider(
          color: Colors.black,
          height: 0,
          thickness: 2,
        ),

        // Profile
        ListTile(
          leading: const Icon(Icons.person_2),
          title: const Text("Profile"),
          onTap: () => Navigator.of(context).pop(),
        ),

        // Settings
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () => Navigator.of(context).pop(),
        ),

        // Feedback
        ListTile(
          leading: const Icon(Icons.feedback),
          title: const Text("Feedback"),
          onTap: () => Navigator.of(context).pop(),
        ),

        // Login
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text("Login"),
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    ));
  }
}
