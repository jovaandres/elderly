class UserData {
  UserData({
    this.age,
    this.email,
    this.height,
    this.name,
    this.role,
    this.weight,
  });

  String age;
  String email;
  String height;
  String name;
  String role;
  String weight;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        age: json["age"],
        email: json["email"],
        height: json["height"],
        name: json["name"],
        role: json["role"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "email": email,
        "height": height,
        "name": name,
        "role": role,
        "weight": weight,
      };
}
