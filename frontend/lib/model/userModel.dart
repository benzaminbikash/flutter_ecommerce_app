import 'dart:convert';

class userModel {
  String? id;
  String? image;
  String? name;
  String? email;
  String? roll;

  userModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.roll,
  });

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        email: json["email"],
        roll: json["roll"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "image": image, "email": email, "roll": roll};

  // @override
  // userModel copyWith({String? name, image}) {
  //   return userModel(
  //       id: id,
  //       name: name ?? this.name,
  //       image: image ?? this.image,
  //       email: email,
  //       roll: roll);
  // }
}
