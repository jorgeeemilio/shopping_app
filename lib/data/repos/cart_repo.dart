// Clase para definir el repositorio del carrito de la compra

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/models/cart_item.dart';

import '../../models/cart_item.dart';

class CartRepo{

  /*
  Esta clase hace uso de las sharedPreferences (lo que cual es escencial para el correcto funcionamiento de la aplicación).
  Una sola variable --> sharedPreferences (para guardar información local en el dipositivo).
  Es decir, si voy añadiendo productos al carrito, cierro la aplicación por completo y la vuelvo a abrir, el carrito sigue manteniendo esos productos.
   */

  final SharedPreferences sharedPreferences;
  CartRepo({ required this.sharedPreferences});
  List<String> cart=[];
  List<String> cartHistory = [];
  List<CartItem> getCartList() {
    //sharedPreferences.remove("Cart-list");
    //sharedPreferences.remove("Cart-list-list");
    List<String> carts = [];
    if(sharedPreferences.containsKey("Cart-list")) {
      carts = sharedPreferences.getStringList("Cart-list")!;
    }
    List<CartItem> cartList = [];

    carts.forEach((cart) => cartList.add(CartItem.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  /*
  Método para añadir al carrito productos.
   */

  void addToCartList(List<CartItem> cartProductList) {
    String time = DateTime.now().toString();
    cart = [];
    cartProductList.forEach((cartModel) {
      /*
      adding time help us to make history of shopping cart.
      based on this we can find the items that were bought at
      one time. This time is unique for every complete order
       */
      cartModel.time=time;
     return cart.add(jsonEncode(cartModel));
    });

    sharedPreferences.setStringList("Cart-list", cart);
  }

  /*
  Método para añadir un ticket al historial de compra.
  Si en las sharedPreferences existe historial de compra, se accede a éste.
  Añadimos al historial los productos del carrito recorriendo la lista tipo String cart.
  Se vacía el carrito.
  Se añaden los cambios a las sharedPreferences
   */

  void addToCartHistoryList() {

    for(int i=0; i<cart.length; i++){
      cartHistory.add(cart[i].replaceAll("\\", ""));
    }
    sharedPreferences.setStringList("Cart-list-list", cartHistory);
    // Vacíamos la Lista del carrito.
    // Borramos las sharedPreferences
    cart=[];
    //sharedPreferences.remove("Cart-list");

  }

  /*
  Método para obtener el historial de compras de un usuario.
  Si las sharedPreferences contienen historial, la lista tipo String cartHistory creada anteriormente, se vacía y, posteriormente, se rellena.
  Se recorre esta lista elemento a elemento y se va a añadienedo el contenido a cartListHistory, en formato Json, porque es una lista tipo CartModel.
   */

  List<CartItem> getCartHistoryList() {
    if(sharedPreferences.containsKey("Cart-list-list")){

      cartHistory = sharedPreferences.getStringList("Cart-list-list")!;
    }else{
      print("...............................nothing.........");
    }
    List<CartItem> cartList = [];
    /*
    We always need to convert the map or json to object or model
     */
    cartHistory.forEach((cart) => cartList.add(CartItem.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  // Método para borrar los productos de un carrito, es decir, para vaciarlo.
  // Se vacía la lista tipo String cart y se borra el carrito de las sharedPreferences.

  void removeCartSharedPreference(){
    //sharedPreferences.remove("Cart-list");
    /*
    bug fix
     */
    //sharedPreferences.remove("Cart-list-list");
  }
}