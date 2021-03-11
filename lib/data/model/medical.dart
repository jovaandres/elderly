class Medical {
  Medical({
    this.id,
    this.name,
    this.rules,
    this.imagePath,
    this.docId,
  });

  int id;
  String name;
  String rules;
  String docId;
  String imagePath;

  factory Medical.fromJson(Map<String, dynamic> json) => Medical(
        id: json["id"],
        name: json["name"],
        rules: json["rules"],
        imagePath: json['imagePath'],
        docId: json["docId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rules": rules,
        "imagePath": imagePath,
        "docId": docId,
      };
}
