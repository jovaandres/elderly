class FamilyNumber {
  FamilyNumber({
    this.id,
    this.name,
    this.number,
  });

  int id;
  String name;
  String number;

  factory FamilyNumber.fromJson(Map<String, dynamic> json) => FamilyNumber(
        id: json["id"],
        name: json["name"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
      };
}
