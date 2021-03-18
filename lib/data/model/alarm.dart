class AlarmData {
  AlarmData({
    this.id,
    this.name,
    this.time,
    this.isScheduled,
  });

  int? id;
  String? name;
  String? time;
  int? isScheduled;

  factory AlarmData.fromJson(Map<String, dynamic> json) => AlarmData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        time: json["time"] == null ? null : json["time"],
        isScheduled: json["isScheduled"] == null ? null : json["isScheduled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "time": time == null ? null : time,
        "isScheduled": isScheduled == null ? null : isScheduled,
      };
}
