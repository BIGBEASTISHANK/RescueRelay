import 'package:flutter/material.dart';
import 'package:rescuerelay/data/data.dart';

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
            currentDisasterDistance: disasterDistance.zeroToFive,
          ),
          SizedBox(height: 5, width: double.infinity), // Spacer

          // Between 5-10
          VolunteerHomeLayout(
            currentDisasterDistance: disasterDistance.fiveToTen,
          ),
          SizedBox(height: 5, width: double.infinity), // Spacer

          // Between 10-15
          VolunteerHomeLayout(
            currentDisasterDistance: disasterDistance.tenToFifteen,
          ),
          SizedBox(height: 5, width: double.infinity), //Spacer

          // Beyond 15km
          VolunteerHomeLayout(
            currentDisasterDistance: disasterDistance.beyondFifteen,
          ),
          SizedBox(height: 20, width: double.infinity), // Spacer
        ],
      ),
    );
  }
}

// layout
class VolunteerHomeLayout extends StatelessWidget {
  final disasterDistance currentDisasterDistance;

  const VolunteerHomeLayout({
    super.key,
    required this.currentDisasterDistance,
  });

  Map<String, Map<String, String>> getDataForDistance() {
    switch (currentDisasterDistance) {
      case disasterDistance.zeroToFive:
        return DisasterData.zeroToFiveData;
      case disasterDistance.fiveToTen:
        return DisasterData.fiveToTenData;
      case disasterDistance.tenToFifteen:
        return DisasterData.tenToFifteenData;
      case disasterDistance.beyondFifteen:
        return DisasterData.beyondFifteenData;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Variable
    String ?distanceTitle;
    final data = getDataForDistance();

    switch (currentDisasterDistance) {
      case disasterDistance.zeroToFive:
        distanceTitle = "Near You (0-5Km)";
        break;
      case disasterDistance.fiveToTen:
        distanceTitle = "Between 5-10 Km";
        break;
      case disasterDistance.tenToFifteen:
        distanceTitle = "Between 10-15 Km";
        break;
      case disasterDistance.beyondFifteen:
        distanceTitle = "Beyond 15 Km";
        break;
    }

    // Return widget
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Distance title
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
          child: Text(
            distanceTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),

        // Disaster card
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: data.entries.map((data) {
              return VHLCard(
                disasterTitle: data.value['title'] ?? '',
                disasterDescription: data.value['description'] ?? '',
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

// Card
class VHLCard extends StatelessWidget {
  final String disasterTitle;
  final String disasterDescription;

  const VHLCard({
    super.key,
    required this.disasterTitle,
    required this.disasterDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 15, right: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Color(0XFF0088CC), width: 2),
      ),
      color: const Color(0XFF0A0C0E),
      child: SizedBox(
        height: 180,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title & description
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    disasterTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    disasterDescription,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              // Buttons row at bottom
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    child: const Text(
                      "Chat",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    child: const Text(
                      "Maps",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}