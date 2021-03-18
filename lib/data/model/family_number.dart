class FamilyNumber {
  FamilyNumber({
    this.id,
    this.name,
    this.number,
    this.docId,
  });

  String? id;
  String? name;
  String? number;
  String? docId;

  factory FamilyNumber.fromJson(Map<String, dynamic> json) => FamilyNumber(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        number: json["number"] == null ? null : json["number"],
        docId: json["docId"] == null ? null : json["docId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "number": number == null ? null : number,
        "docId": docId == null ? null : docId,
      };
}
