// Controlador del carrito

import 'dart:core';

import 'package:get/get.dart';

import 'package:shopping_app/data/repos/cart_repo.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/models/product.dart';

class CartController extends GetxController {

  // Una variable tipo CartRepo (Repositorio del carrito).

  final CartRepo cartRepo;
  CartController({required this.cartRepo, productRepo});

  /*
  Dos variables tipo Map para obtener los productos al carrito.
  Una variable tipo Lista para guardar los productos al carrito.
   */

   Map<int, CartItem> _items = {};
   //late Map<int, CartItem> savedItems={};

    /*
    Método para para modificar el carrito.
     */
    List<CartItem> storageItems=[];
    // set here from sharedPreference when started the app
   set setCart(List<CartItem> items){
    // storageItems = items;
     for(int i=0; i<storageItems.length; i++){
       //print(storageItems[i].quantity);
       _items.putIfAbsent(
         storageItems[i].product.id,
           /*
           made code simpler.
            */
           ()=>items[i]
            /* () => CartItem(
           id: storageItems[i].id,
           title: storageItems[i].title,
           price: storageItems[i].price,
           quantity: storageItems[i].quantity,
                 img:storageItems[i].img,
               product: storageItems[i].product,
               time:DateTime.now().toString()
         ),*/
       );
     }
   }

  /*
  Método para obtener los productos del carrito.
   */

  Map<int, CartItem> get items {
     return _items;
  }

  set setItems(Map<int, CartItem> setItems) {
     _items={};
     _items=setItems;
  }

  List<CartItem> _cartList=[];
  void clearCartList() {
    _cartList = [];
    cartRepo.addToCartList(_cartList);
    update();
  }

  void addToCarts(CartItem cart){
    _cartList.add(cart);
    Get.find<CartRepo>().addToCartList(_cartList);
  }
  /*
  Método para obtener la data del carrito.
   */
  List<CartItem> getCartsData(){
    //retreive all the info the storage and set it to
    //_items through setCart
   setCart= Get.find<CartRepo>().getCartList();

   return storageItems;
  }
  //map converts to list
  //We need to convert this to list since we want to
  //send the cart info the sharedpreferecen.
  //Shared preference only works with list
  //this list also has the latest update throughout the app
  List<CartItem> get getCarts{
   return items.entries.map((e) {
     return e.value;
   }).toList();

  }

  int _certainItems=0;
  int get certainItems=>_certainItems;
  //get totalAmount=>_totalAmount;

  int get itemCount{
      // return  _items?.length?? 0;
  return _items.length;

  }

  /*
  Método para obtener el coste total del pedido.
  Precio * cantidad
   */

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  /*
  Método para obtener el número total de productos.
   */

  int get totalItems{
    var total=0;
    _items.forEach((key, value) {
      total +=value.quantity;

    });
    return total;
  }

  /*
  Método para añadir un producto, con su cantidad correspondiente al carrito.
  Solamente para caché y sharedPreferences (local).
  Dos parámetros: ProductModel y cantidad.
  Hay varias condiciones.

          - Si en el carrito SÍ se encuentra ese producto:
                  - El carrito se actualiza.
                  - La cantidad de productos en el carrito varía (el número se actualiza al estado actual).
                  - Si el carrito está vacío:
                          - Se borran los productos.

          - Si en el carrito NO se encuentra ese producto añadido:
                  - Si la cantidad que se pasa por parámetro es mayor que 0:
                            - El producto se añade al carrito.
                  - Si la cantidad que se pasa por parámetro es 0 o menor que 0:
                            - Sale una notificación avisando del error.

          - Se añaden al carrito los productos.
          - Se actualiza.
   */

  void addItem(Product product, int quantity) {
    int total=0;
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existingCartItem){
         total=   existingCartItem.quantity+quantity;
            return CartItem(
              id: existingCartItem.id.toString(),
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + quantity,
              price: existingCartItem.price,
              img:product.img,
              product: product,
              time:DateTime.now().toString());
            },
              );
      /*
      with this we are making sure, we are removing all
      items that has zero quantity in the cart. This way cart
      would automatially get updated
       */
            if(total<=0){
              _items.remove(product.id);
             // print("removed");
            }else{
             // print("not remove");
            }
      update();

    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: product.id.toString(),
          title: product.title,
          price: product.price,
          quantity: quantity,
          img:product.img,
          product: product,
            time:DateTime.now().toString()
        ),
      );
    }
    // this makes sure that we are saving in the sharedpreference every time user clicks to add to cart button
    cartRepo.addToCartList(getCarts);
    update();
  }

  void addToCartList(){
    cartRepo.addToCartList(getCarts);

  }

  /*
  Método para añadir el pedido al historial del usuario.
   */

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    /*
    _items should be set to empty after adding. So we created clear method. It sets it to empty
     */
    clear();
  }

  List<CartItem> getCartHistory(){
   return cartRepo.getCartHistoryList();
  }

  /*
  Método para saber si el producto existe en el carrito o no.
   */

  bool isExistInCart(Product product){

    if(_items.containsKey(product.id)){
     _items.forEach((key, value) {
       print(key.toString());
       if(key==product.id){
        //value.quantity.toString()
         value.isExist=true;
       }
     });
      return true;
    }else{
      return false;
    }
  }

  /*
  Método para obtener la cantidad de algún producto.
   */

  int getQuantity(Product product){
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
       // print(key.toString());
        if(key==product.id){
          //value.quantity.toString()
          _certainItems=int.parse(value.quantity.toString());
        }
      });
      return _certainItems;
    }else{
      return 0;
    }
  }

  void removeItem(int productId){
    _items.remove(productId);
    update();
  }

  /*
  Método para vaciar el carrito
  Se usa cuando se procede a pagar el pedido.
   */

  void clear(){
    _items = {};
    update();
  }

  void removeCartSharedPreference(){
    cartRepo.removeCartSharedPreference();
  }
}
