class UserData {
  UserData({
    this.age,
    this.email,
    this.height,
    this.name,
    this.role,
    this.weight,
  });

  String? age;
  String? email;
  String? height;
  String? name;
  String? role;
  String? weight;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        age: json["age"] == null ? null : json["age"],
        email: json["email"] == null ? null : json["email"],
        height: json["height"] == null ? null : json["height"],
        name: json["name"] == null ? null : json["name"],
        role: json["role"] == null ? null : json["role"],
        weight: json["weight"] == null ? null : json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "age": age == null ? null : age,
        "email": email == null ? null : email,
        "height": height == null ? null : height,
        "name": name == null ? null : name,
        "role": role == null ? null : role,
        "weight": weight == null ? null : weight,
      };
}
