// Pantalla que muestra los Detalles de una PopularFood

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/components/expanded_widget.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/icon_text_widget.dart';
import 'package:get/get.dart';


class DetailFood extends StatelessWidget {

  /*
  Dos variables.
  pageId --> id de la página
  page --> nombre de la página
   */

  int pageId;
  String page;
  DetailFood({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(Get.find<CartController>().getCartsData());
    //we are getting a model here
    print("hi........."+pageId.toString());

    // Hace uso del controlador: PopularProductController para acceder a la lista de los productos populares.

    var productItem = Get.find<ProductController>().popularProductList[pageId];
    Get.find<ProductController>().initData(productItem, pageId, Get.find<CartController>()
    );

    // Devuelve Scaffold (Clase que implementa los materiales básicos de diseño de una estrucutra layout, conocidos como "material design").

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.sliverHeight,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,

                      // Se carga las imágenes de la API

                    image: NetworkImage(
                      AppConstants.UPLOADS_URL+productItem.img
                    )
                  )
                ),
              )),
          //icon widgets
          Positioned(
            top: 50,
              left: 20,
              right: 20,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white70,
                    ),

                    /*
                  Al pulsar en el botón Atrás pueden pasar dos situaciones:
                        - Si venimos de CartPage vamos a CartPage.
                        - Si venimos de HomePage vamos a HomePage.
                  */

                    child: GestureDetector(
                      onTap: (){
                       // Get.toNamed(RouteHelper.getInitialRoute());
                        Get.back();
                      },
                      child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: Colors.black54,
                          )),
                    ),
                  ),

                  // Al pulsar el botón del carrito vamos a CartPage

                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getCartPage(pageId, page));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 0),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70,
                      ),
                      child: GetBuilder<CartController>(builder:(_){
                        return Stack(
                          children: [
                            Positioned(
                              child: Center(
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 16,
                                    color: Colors.black54,
                                  )),
                            ),

                            //Se hace uso del controler: PopularProductController para conocer la cantidad total de productos.
                            // En consecuencia, se crea un Positioned con una serie de valores o se crea un Container vacío.

                            Get.find<CartController>().totalItems>=1?Positioned(
                              right: 5,
                              top:5,
                              child: Center(
                                  child: Icon(
                                    Icons.circle,
                                    size: 16,
                                    color: AppColors.mainColor,
                                  )),
                            ):Container(),
                            Get.find<CartController>().totalItems>1?Positioned(
                              right: 8,
                              top:6,
                              child: Center(
                                  child:  Text(
                                    Get.find<CartController>().totalItems.toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ):Container()
                          ],
                        );
                      }),
                    ),
                  )
                ],
              )),

          // Introducción de la comida

          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.sliverHeight-30,
           // bottom: 0,
              child: Container(
                 height: 500,
                //width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 20, right: 20, top:20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.padding20),
                        topLeft: Radius.circular(Dimensions.padding20))),

                /*
                    AppColumn que contiene:
                          - Nombre del plato
                          - Media de tiempo (lento, medio, rápido)
                          - Alergénos
                          - Duración estimada de cocción
                     */

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                        size: Dimensions.font26,
                        text: productItem.title,
                        color: Colors.black87),
                    SizedBox(
                      height: Dimensions.padding20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(text: productItem.title.startsWith("Tortilla") ? "Medio" : productItem.title.startsWith("Jamón") ? "Rápido" : productItem.title.startsWith("Salmorejo") ? "Rápido" : productItem.title.startsWith("Gazpacho") ? "Rápido" : productItem.title.startsWith("Paella") ? "Lento" : "",
                          color: AppColors.textColor,
                          icon: Icons.circle_sharp,
                          iconColor: productItem.title.startsWith("Tortilla") ? AppColors.amarillo : productItem.title.startsWith("Jamón") ? AppColors.verde : productItem.title.startsWith("Salmorejo") ? AppColors.verde : productItem.title.startsWith("Gazpacho") ? AppColors.verde : productItem.title.startsWith("Paella") ? AppColors.naranja : AppColors.mainColor,
                        ),
                        IconAndTextWidget(text: productItem.title.startsWith("Tortilla") ? "Huevos" : productItem.title.startsWith("Jamón") ? "Nada" : productItem.title.startsWith("Salmorejo") ? "Gluten" : productItem.title.startsWith("Gazpacho") ? "Sulfito" : productItem.title.startsWith("Paella") ? "Pescado" : "",
                          color: AppColors.textColor, icon: productItem.title.startsWith("Tortilla") ? Icons.egg : productItem.title.startsWith("Jamón") ? Icons.done : productItem.title.startsWith("Salmorejo") ? Icons.spa : productItem.title.startsWith("Gazpacho") ? Icons.science : productItem.title.startsWith("Paella") ? Icons.waves : Icons.done,
                          iconColor: productItem.title.startsWith("Tortilla") ? AppColors.huevos : productItem.title.startsWith("Jamón") ? AppColors.verde : productItem.title.startsWith("Salmorejo") ? AppColors.gluten : productItem.title.startsWith("Gazpacho") ? AppColors.sulfitos : productItem.title.startsWith("Paella") ? AppColors.pescado : AppColors.mainColor,),
                        IconAndTextWidget(
                          text: productItem.title.startsWith("Tortilla") ? "30 m" : productItem.title.startsWith("Jamón") ? "5 m" : productItem.title.startsWith("Salmorejo") ? "15 m" : productItem.title.startsWith("Gazpacho") ? "15 m" : productItem.title.startsWith("Paella") ? "1 h" : "30 m",
                          color: AppColors.textColor,
                          icon: Icons.access_time_rounded,
                          iconColor: AppColors.iconColor2,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.padding20,
                    ),
                    BigText(
                        size: 22,
                        text: "Introducción",
                        color: AppColors.titleColor),
                    SizedBox(
                      height: Dimensions.padding10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DescriptionTextWidget(text:productItem.description),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),

      /*
      NaigationBar formada:
            - A la izquierda, la cantidad de unidades (se puede modicar con los botones - y +).
            - A la derecha, un boón con el precio del producto y que pone "Añadir al carrito".
       */

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: Dimensions.detailFoodImgPad,
            right: Dimensions.detailFoodImgPad),
        height: Dimensions.buttonButtonCon,
        padding:
             EdgeInsets.only(top: Dimensions.padding30,
                 bottom: Dimensions.padding30, left: 20, right: 20),
        child: Row(
          children: [
            Container(
              padding:  EdgeInsets.all(Dimensions.padding20),
              child: Row(
                children: [

                  // Icono - reduce la cantidad al ser pulsado

                  GestureDetector(
                    onTap: (){
                      Get.find<ProductController>().setQuantity(false, productItem);
                    },
                    child: Icon(Icons.remove, color: AppColors.signColor),
                  ),
                  SizedBox(width: Dimensions.padding10),

                  // Cantidad de unidades del plato

                  GetBuilder<ProductController>(builder: (_){
                    return BigText(text: Get.find<ProductController>().certainItems.toString(), color: AppColors.mainBlackColor);
                  },),
                  SizedBox(width: Dimensions.padding10),

                  // Icono + aumenta la cantidad al ser pulsado

                  GestureDetector(
                    onTap: (){
                      Get.find<ProductController>().setQuantity(true, productItem);
                    },
                    child: Icon(Icons.add, color: AppColors.signColor),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.padding20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        //spreadRadius: 3,
                        color: AppColors.titleColor.withOpacity(0.05))
                  ]),
            ),
            Expanded(child: Container()),

            // Botón de añadir al carrito.
            // Al pulsar en él se añaden tantos productos como haya indicado el usuario.

            GestureDetector(
              onTap: (){
                Get.find<ProductController>().addItem(productItem);
                Get.snackbar("Producto", "Añadido con éxito");
              },
              child: Container(
                child: BigText(
                  size: 20,
                  text: (productItem.price.round()).toString()+"\€"+ " | Añadir",
                  color: Colors.white,
                ),
                padding:  EdgeInsets.all(Dimensions.padding20),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.padding20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 10,
                          //spreadRadius: 3,
                          color: AppColors.mainColor.withOpacity(0.3))
                    ]),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.padding40),
              topRight: Radius.circular(Dimensions.padding40),
            )),
      ),
    );
    // );
  }
}
