import 'dart:convert';

class PostsModal {
  String? id;
  String? title;
  String? image;
  String? description;
  String? price;
  String? status;
  bool? isFavorite;
  int? qty;
  PostsModal(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.price,
      this.status,
      this.isFavorite,
      this.qty});

  factory PostsModal.fromJson(Map<String, dynamic> json) => PostsModal(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
        status: json["status"],
        isFavorite: false,
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "price": price,
        "status": status,
        'isFavorite': isFavorite,
        'qty': qty
      };
  @override
  PostsModal copyWith({
    int? qty,
    String? title,
    String? image,
    String? price,
    String? description,
  }) {
    return PostsModal(
        id: id,
        title: title ?? this.title,
        image: image ?? this.image,
        description: description ?? this.description,
        price: price ?? this.price,
        status: status,
        isFavorite: isFavorite,
        qty: qty ?? this.qty);
  }
}
