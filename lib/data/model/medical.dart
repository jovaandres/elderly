class Medical {
  Medical({
    this.id,
    this.name,
    this.rules,
    this.imagePath,
    this.docId,
  });

  int? id;
  String? name;
  String? rules;
  String? docId;
  String? imagePath;

  factory Medical.fromJson(Map<String, dynamic> json) => Medical(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        rules: json["rules"] == null ? null : json["rules"],
        docId: json["docId"] == null ? null : json["docId"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "rules": rules == null ? null : rules,
        "docId": docId == null ? null : docId,
        "imagePath": imagePath == null ? null : imagePath,
      };
}
