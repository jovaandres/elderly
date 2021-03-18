class AlarmData {
  AlarmData({
    this.id,
    this.name,
    this.time,
    this.isScheduled,
  });

  int id;
  String name;
  String time;
  int isScheduled;

  factory AlarmData.fromJson(Map<String, dynamic> json) => AlarmData(
        id: json["id"],
        name: json["name"],
        time: json["time"],
        isScheduled: json["isScheduled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time,
        "isScheduled": isScheduled,
      };
}
