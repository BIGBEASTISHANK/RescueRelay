import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0XFF0A0C0E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Header Background
            const DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: Color(0XFF0088CC),
                  image: DecorationImage(
                    image: AssetImage("assets/img/blurDisaster.jpg"),
                    fit: BoxFit.fill,
                  )),
              // Title of the app
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
              leading: const Icon(
                Icons.person_2,
                color: Colors.white,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),

            // Settings
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),

            // Feedback
            ListTile(
              leading: const Icon(
                Icons.feedback,
                color: Colors.white,
              ),
              title: const Text(
                "Feedback",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),

            // Login
            ListTile(
              leading: const Icon(
                Icons.login,
                color: Colors.white,
              ),
              title: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ));
  }
}
