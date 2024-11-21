import 'package:flutter/material.dart';

// Home Page
class VolunteerHome extends StatelessWidget {
  const VolunteerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Near you 0-5
          VolunteerHomeLayout(
            distanceTitle: "Near You (0-5Km)",
          ),
          SizedBox(height: 5, width: double.infinity), // Spacer

          // Between 5-10
          VolunteerHomeLayout(
            distanceTitle: "Between 5-10 Km",
          ),
          SizedBox(height: 5, width: double.infinity), // Spacer

          // Between 10-15
          VolunteerHomeLayout(
            distanceTitle: "Between 10-15 Km",
          ),
          SizedBox(height: 5, width: double.infinity), //Spacer
          
          // Beyond 15km
          VolunteerHomeLayout(
            distanceTitle: "Beyond 15 Km",
          ),

          // Spacer
          SizedBox(height: 20, width: double.infinity),
        ],
      ),
    );
  }
}

// layout
class VolunteerHomeLayout extends StatelessWidget {
  final String distanceTitle;

  const VolunteerHomeLayout({
    super.key,
    required this.distanceTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Distance title
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
          child: Text(
            distanceTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),

        // Disaster card
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              VHLCard(
                cardColor: Colors.red,
                disasterTitle: "HI",
                disasterDescription: "hi",
              ),
              VHLCard(
                cardColor: Colors.blue,
                disasterTitle: "HI",
                disasterDescription: "hsi",
              ),
            ],
          ),
        )
      ],
    );
  }
}

// Card
class VHLCard extends StatelessWidget {
  final Color cardColor;
  final String disasterTitle;
  final String disasterDescription;

  const VHLCard({
    super.key,
    required this.cardColor,
    required this.disasterTitle,
    required this.disasterDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(left: 15, right: 15),
        color: cardColor,
        child: SizedBox(
          height: 150,
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(disasterTitle),
                subtitle: Text(disasterDescription),
              )
            ],
          ),
        ));
  }
}
