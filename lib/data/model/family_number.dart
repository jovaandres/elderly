class FamilyNumber {
  FamilyNumber({
    this.id,
    this.name,
    this.number,
    this.docId,
  });

  int id;
  String name;
  String number;
  String docId;

  factory FamilyNumber.fromJson(Map<String, dynamic> json) => FamilyNumber(
      id: json["id"],
      name: json["name"],
      number: json["number"],
      docId: json['docId']);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "number": number, "docId": docId};
}
