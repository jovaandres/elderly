class Activity {
  Activity({
    this.id,
    this.activity,
  });

  String? id;
  String? activity;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"] == null ? null : json["id"],
        activity: json["activity"] == null ? null : json["activity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "activity": activity == null ? null : activity,
      };
}
