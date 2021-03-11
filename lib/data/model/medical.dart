class Medical {
  Medical({
    this.id,
    this.name,
    this.rules,
    this.docId,
  });

  int id;
  String name;
  String rules;
  String docId;

  factory Medical.fromJson(Map<String, dynamic> json) => Medical(
        id: json["id"],
        name: json["name"],
        rules: json["rules"],
        docId: json["docId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rules": rules,
        "docId": docId,
      };
}
