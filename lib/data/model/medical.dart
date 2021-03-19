class Medical {
  Medical({
    this.id,
    this.name,
    this.rules,
    this.imagePath,
    this.docId,
    this.times,
    this.alarmId,
  });

  int? id;
  String? name;
  String? rules;
  String? docId;
  String? imagePath;
  List<String>? times;
  List<int>? alarmId;

  factory Medical.fromJson(Map<String, dynamic> json) => Medical(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        rules: json["rules"] == null ? null : json["rules"],
        docId: json["docId"] == null ? null : json["docId"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
        times: json["times"] == null
            ? null
            : List<String>.from(json["times"].map((x) => x)),
        alarmId: json["alarmId"] == null
            ? null
            : List<int>.from(json["alarmId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "rules": rules == null ? null : rules,
        "docId": docId == null ? null : docId,
        "imagePath": imagePath == null ? null : imagePath,
        "times": times == null
            ? null
            : List<String>.from((times as List<String>).map((x) => x)),
        "alarmId": alarmId == null
            ? null
            : List<int>.from((alarmId as List<int>).map((x) => x)),
      };
}
