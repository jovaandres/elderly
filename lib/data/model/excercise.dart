class Excercise {
  Excercise({
    this.id,
    this.name,
    this.image,
  });

  int id;
  String name;
  String image;

  factory Excercise.fromJson(Map<String, dynamic> json) => Excercise(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
