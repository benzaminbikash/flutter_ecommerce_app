import 'dart:convert';

class CategoryModel {
  String? id;
  String? image;
  String? title;

  CategoryModel({
    this.id,
    this.title,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}
