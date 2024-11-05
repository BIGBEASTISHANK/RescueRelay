import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                image: DecorationImage(
                  image: AssetImage("assets/img/blurDisaster.jpg"),
                  fit: BoxFit.fill,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  "Rescue Relay",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            )),

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
