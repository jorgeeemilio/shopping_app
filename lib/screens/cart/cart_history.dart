// Pantalla que muestra el Historial de Compras del Usuario

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/base/no_data_found.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/models/cart_item.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/uitls/styles.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*
we we have list of objects. First we find just get all the time
and then we find the unique time. At the same time we also find how
many times a certain time is found
 */
    var cartHistory=[];
    var originalHistory=[];

    // Tiene implementado el controller de carrito (CartController)
    // Se da la vuelta a la lista para que arriba estén los últimos pedidos, en lugar de abajo
    // Una variable tipo Map para manipular los productos por cada compra
    // Se recorre la lista del historial de compra y se añade al mapa la fecha y el valor

    originalHistory =  Get.find<CartController>().getCartHistory();
    Iterable inReverse = originalHistory.reversed;
    cartHistory = inReverse.toList();
    var listOfTime=[];
    for(int i=0; i<cartHistory.length; i++){
      listOfTime.add(cartHistory[i].time);
      print(cartHistory[i].img);
    }
    var cartItemsPerOrder = {};
    cartItemsPerOrder= Map<String, dynamic>();

    for(int i=0; i<cartHistory.length; i++){
      /*
      How many times a certain time is found in the list.
      The time number is used the wrap loop to show the itmes
      from a certain buy
       */
      if(cartItemsPerOrder.containsKey(cartHistory[i].time)){
        cartItemsPerOrder.update(cartHistory[i].time, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(cartHistory[i].time??DateTime.now().toString(), () => 1);
      }
    }

    // Método para castear los productos de un pedido a lista

    List<dynamic> cartOrderTimeList(){
      return cartItemsPerOrder.entries.map((e){
        return e.value;
      }).toList();
    }

    // Método para castear la fecha de un pedido a lista

    List<dynamic> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e){
        return e.key;
      }).toList();
    }
    var xy=[];
    xy = cartOrderTimeList();
    var listCounter=0;
    Widget timeWidget(int index){
      var outputDate="";
      if(index<cartHistory.length){

        // Widget para mostrar una fecha en formato europeo. Ejemplo: 14/04/2022 21:29
        // Para hacer el cambio a formato europeo he importado la librería intl: ^0.17.0

        DateTime parseDate=  DateFormat("yyyy-MM-dd HH:mm:ss").parse(cartHistory[index].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat=DateFormat("dd/MM/yyyy HH:mm");
         outputDate = outputFormat.format(inputDate);

      }
      return BigText(text:outputDate, color:AppColors.titleColor);
    }

    /*
    Devuelve Scaffold (Clase que implementa los materiales básicos de diseño de una estrucutra layout, conocidos como "material design").
    Formado por:
          - Columna con el título e icono de la Página: CART HISTORY
          - Se evalua una condición: Para ello se usa un cartController y el método getCartHistoryList()
                - Si las lista del historial de compra está LLENA:
                      - Se crea un Widget tipo Expanded, es decir, se expande hacia abajo.
                Si la lista del histoiral de compra está VACÍA:
                      - Se muestra una foto de una caja vacía, junto a un mensaje de feedback al usuario.
     */

    return  Scaffold(
      body: Column(
        children: [

          //Container que contiene una Columna títulada: CART HISTORY

          Container(
            height: 100,
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text:"Historial de compra",
                    color: Colors.white,size:24),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getCartPage(0, "cart-history"));
                  },
                  child: Icon(Icons.shopping_cart_outlined, size:30, color:Colors.white),
                )
              ],
            ),

            decoration: BoxDecoration(
              color: AppColors.mainColor,

            ),
          ),

          // Si la lista del historial de compra está llena

          GetBuilder<CartController>(builder: (_cartController){
            print("History length is "+_cartController.getCartHistory().length.toString());

            // Expanded, Container --> Comienza el Widget Expanded, cuyo hijo es un Container

            return _cartController.getCartHistory().length>0? Expanded(child:   Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                //height: double.maxFinite,

                child: MediaQuery.removePadding(context: context, removeTop: true,

                  // ListView --> Lista donde se muestran los pedidos

                  child: ListView(
                    children: [
                      for(int index=0; index<xy.length; index++)

                      // Container --> Contenedor de la izquierda

                        Container(
                          height: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                height: 130,

                                // Column --> Columna de la izquierda

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    timeWidget(listCounter),
                                   /* ((){

                                      DateTime parseDate=  DateFormat("yyyy-MM-dd HH:mm:ss").parse(cartHistory[listCounter].time!);
                                      var inputDate = DateTime.parse(parseDate.toString());
                                      var outputFormat= DateFormat("MM/dd/yyyy hh:mm a");
                                      var outputDate = outputFormat.format(inputDate);
                                      return BigText(text:outputDate, color:AppColors.titleColor);*/
                                   // }()
                                   // ),*/

                                    // Wrap --> Widget que muestra los hijos en horizontal o vertical

                                    Wrap(
                                        direction: Axis.horizontal,

                                        // List.generate --> Generar una lista según los productos que hay por cada pedido

                                        children: List.generate(xy[index], (index1) {
                                          if(listCounter<cartHistory.length) {
                                            listCounter++;
                                          }
                                          if (index1 <= 2) {

                                            // Container --> Si hay como máximo dos productos en el pedido

                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10, bottom: 20, top: 5),
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(8),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        /*
                                saveCounter is actually the same as the
                                items in the original list of cart history
                                 */
                                                          AppConstants
                                                              .UPLOADS_URL +
                                                              cartHistory[listCounter -
                                                                  1].img
                                                      )
                                                  )
                                              ),
                                            );
                                          } else{

                                            //Container --> Si hay más de dos productos en el pedido

                                            return Container();
                                          }

                                        })
                                    ),

                                  ],
                                ),
                              ),

                              // Container --> Contenedor de la derecha

                              Container(
                                height: 100,

                                // Column --> Columna de la derecha

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    // SmallText, BigText, GestureDetector
                                    // Ejemplo: Total, 2 Items, one more

                                    TextWidget(text: "Total", color: AppColors.mainBlackColor),
                                    BigText(text:xy[index].toString()+" Plato/s", color:AppColors.titleColor),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,
                                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                        border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                      ),
                                      child: Row(children: [
                                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        GestureDetector(

                                          // onTap
                                          // Al pulsar en one more se redirige a CartPage para poder modificar el pedido

                                          onTap: (){

                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartItem> moreOrder ={};
                                            for(int j=0; j<cartHistory.length; j++){
                                              if(cartHistory[j].time==orderTime[index]){
                                                print(orderTime[index]+" J is "+j.toString());
                                                print(jsonEncode(cartHistory[j]));
                                                moreOrder.putIfAbsent(int.parse(cartHistory[j].id), () =>
                                                    CartItem.fromJson(jsonDecode(jsonEncode(cartHistory[j]))));
                                              }
                                            }
                                            Get.find<CartController>().setItems=moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage(0, "cart-history"));
                                          },

                                          // SmallText --> Texto del botón one more

                                          child: Text("uno más", style: robotoMedium.copyWith(
                                            fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor,
                                          )),
                                        ),
                                      ]),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )

                    ],
                  ),)

              // Si la lista del historial de compra está vacía

            )):NoDataScreen(text: "Historial vacío ");
          })
    ]));
  }
}

/*
La estrucutra del Widget Expanded es un poco en enrevesada.
Un resumen sería así:
- Expanded
  - Container
    - MediaQuery
      - ListView
        - Container
          - Column
            - Row
              - Wrap
                - List.generate
                  - Container
                  - Container
              - Container
                - Column
                  - SmallText
                  - BigText
                  - GestureDetector
                    - onTap
                    - Container
                      - SmallText
 */

