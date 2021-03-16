class Activity {
  Activity({
    this.id,
    this.activity,
  });

  String id;
  String activity;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        activity: json["activity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activity": activity,
      };
}
