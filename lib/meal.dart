class Meal {
  final int? id;
  final String name;
  final double price;
  final String image;

  const Meal(this.name, this.price, this.image, [this.id]);

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'name': name,
      'price': price,
      'image': image
    };
  }

  Meal.fromMap(Map<String, dynamic> map):
    id = map['id'],
    name = map['name'],
    price = map['price'],
    image = map['image'];
}
