import './category_model.dart';
class Product {
  int? id;
  String? name;
  double? price;
  int quantity;
  String? image;
  String? description;
  Category? category;
  String? brand;
  Product(this.id, this.name, this.price, this.quantity, this.image,
      this.description, this.category,this.brand);

}
