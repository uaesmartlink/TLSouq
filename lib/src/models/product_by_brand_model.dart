class ProductByBrandModel {
  ProductByBrandModel({
    this.success,
    this.message,
   required this.data,
  });

  ProductByBrandModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  late final List<Data> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.slug,
    this.title,
    this.shortDescription,
    this.specialDiscountType,
    this.specialDiscount,
    this.discountPrice,
    this.image,
    this.price,
    this.rating,
    this.totalReviews,
    this.currentStock,
    this.totalSale,
    this.reward,
    this.minimumOrderQuantity,
    this.isNew,
    this.hasVariant,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    shortDescription = json['short_description'];
    specialDiscountType = json['special_discount_type'];
    specialDiscount = json['special_discount'];
    discountPrice = json['discount_price'];
    image = json['image'];
    price = json['price'];
    rating = json['rating'];
    totalReviews = json['total_reviews'];
    currentStock = json['current_stock'];
    totalSale = json['total_sale'];
    reward = json['reward'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    isNew = json['is_new'];
    hasVariant = json['has_variant'];
  }
  int? id;
  String? slug;
  String? title;
  String? shortDescription;
  String? specialDiscountType;
  dynamic specialDiscount;
  dynamic discountPrice;
  String? image;
  dynamic price;
  dynamic rating;
  int? totalReviews;
  int? currentStock;
  int? totalSale;
  int? reward;
  int? minimumOrderQuantity;
  bool? isNew;
  bool? hasVariant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['short_description'] = shortDescription;
    map['special_discount_type'] = specialDiscountType;
    map['special_discount'] = specialDiscount;
    map['discount_price'] = discountPrice;
    map['image'] = image;
    map['price'] = price;
    map['rating'] = rating;
    map['total_reviews'] = totalReviews;
    map['current_stock'] = currentStock;
    map['total_sale'] = totalSale;
    map['reward'] = reward;
    map['minimum_order_quantity'] = minimumOrderQuantity;
    map['is_new'] = isNew;
    map['has_variant'] = hasVariant;
    return map;
  }
}
