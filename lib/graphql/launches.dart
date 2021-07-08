class Launches {
  final String missionName;

  Launches({
    required this.missionName,
  });

  factory Launches.fromJson(Map<String, dynamic> json) {
    return Launches(
      missionName: json['mission_name'] as String,
    );
  }
}
