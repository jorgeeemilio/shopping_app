// Clase POJO de carrito.

import 'package:shopping_app/models/product.dart';

class CartItem {

  /*
  Ocho atributos. Son todas opcionales (?).
  id --> id
  name --> nombre
  price --> precio
  img --> imagen
  quantity --> cantidad
  isExist --> si el producto está en el carro o no
  time --> fecha
  product --> producto (ProductModel)
   */

  String id;
  String title;
  int quantity;
  double price;
  bool isExist;
  String img;
  String time;
  Product product;

  // Constructor

  CartItem({ required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    this.isExist = false,
    required this.img,
    required this.time,
    required this.product
  });

  // Mapeo de formato Json a tipo String.
  // Se obtienen todos los atributos del carrito.

  factory CartItem.fromJson(Map<String, dynamic> json){
    return CartItem(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      isExist: json['isExist'],
      img:json['img']??"img/food0.png",
      time:json['time'],
      product: Product.fromJson(json['product'])
    );
  }

  // Mapeo de tipo String a formato Json.
  // Se devuelven todos los atributos del carrito.

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "quantity": this.quantity,
      "price": this.price,
      "isExist": this.isExist,
      'img':this.img,
      'time':this.time,
      //this part we need for accessing the product model
      //so we will this part later
      'product':this.product.toJson()
    };
  }
}
