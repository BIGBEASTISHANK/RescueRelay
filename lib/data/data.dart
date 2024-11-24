// Total Account types
enum accountTypes {
  volunteer,
  hosts
}

accountTypes currentAccountType = accountTypes.volunteer;

// Distance
enum disasterDistance {
  zeroToFive,
  fiveToTen,
  tenToFifteen,
  beyondFifteen
}

// CardData
class DisasterData {
  // Zero to five data
  static final Map<String, Map<String, String>> zeroToFiveData = {
    "0": {
      "title": "Flood in Bagru",
      "description": "Flutter is an open-source UI software development kit created by Google. It can be used to develop crossplatform.",
    },
    "1": {
      "title": "Landslide Alert",
      "description": "Heavy rainfall has caused landslide risks in the hillside area.",
    },
  };

  // Five to ten data
  static final Map<String, Map<String, String>> fiveToTenData = {
    "0": {
      "title": "Fire Emergency",
      "description": "Industrial area fire reported, emergency services en route.",
    },
  };

  // Ten to fifteen data
  static final Map<String, Map<String, String>> tenToFifteenData = {
    "0": {
      "title": "Storm Warning",
      "description": "Severe thunderstorm approaching from the northwest.",
    },
  };

  // Beyond fifteen data
  static final Map<String, Map<String, String>> beyondFifteenData = {
    "0": {
      "title": "Earthquake Impact",
      "description": "Moderate earthquake effects reported in outer regions.",
    },
  };
}