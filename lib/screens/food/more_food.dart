// Pantalla que muestra los detalles de una RecommendedFood

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/components/expanded_widget.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/uitls/app_constants.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class MoreFood extends StatelessWidget {

  /*
  Dos variables.
  pageId --> id de la página
  page --> nombre de la página
   */

  int pageId;
  String page;
  String route;

  MoreFood({Key? key, required this.pageId, required this.page, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Hace uso del controlador: RecommendedProductController para acceder a la lista de los productos recomendados.

    var productItem = Get.find<PopularProduct>().popularProductList[pageId];
    Get.find<ProductController>()
        .initData(productItem, pageId, Get.find<CartController>());

    // Devuelve Scaffold (Clase que implementa los materiales básicos de diseño de una estrucutra layout, conocidos como "material design").

    return  Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5, top:10),
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),

                      )
                  ),
                  width: double.maxFinite,
                  child:Center(
                    child: BigText(
                        text:productItem.title, color:AppColors.mainBlackColor
                    ),
                  ),
                ),
              ),
            //without this we see an arrow
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.yellowColor,
            //without this the top bar is very thin
              //it starts from bottom
            toolbarHeight: 60,
            floating: false,
              //stick top
            pinned: true,
            expandedHeight: 300,

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.UPLOADS_URL + productItem.img,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: Dimensions.moreViewCon,
              ),
              //titlePadding: EdgeInsets.all(16),
              title: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left:20),
                    width: 30,
                    height: 30,

                    /*
                    Al pulsar en el botón Atrás vamos atrás
                  */

                    child: GestureDetector(
                        onTap: (){
                          //Get.offNamed(RouteHelper.getInitialRoute());
                          Get.back();
                        },
                        child: Center(child: TextWidget(text: "X",color: Colors.black54,))),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 5,
                              color: Colors.grey.withOpacity(0.1)
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                  ),
                  Expanded(child: Container()),

                  // Al pulsar el botón del carrito vamos a CartPage

                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getCartPage(pageId, page));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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

                            //Se hace uso del controler: PopularProductController para conocer la cantidad total de productos
                            // En consecuencia, se crea un Positioned con una serie de valores o se crea un Container vacío.

                            Get.find<CartController>().totalItems>=1?Positioned(
                              right: 2,
                              top:2,
                              child: Center(
                                  child: Icon(
                                    Icons.circle,
                                    size: 16,
                                    color: AppColors.mainColor,
                                  )),
                            ):Container(),
                            Get.find<CartController>().totalItems>1?Positioned(
                              right: 4,
                              top:3,
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
              ),
          )),

          // Platos con nombre, imagen y título

          SliverToBoxAdapter(

            child: Column(
              children: [
                //SizedBox(height: 10,),
                Container(

                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child:  DescriptionTextWidget(text: productItem.description)
                ),
              ],
            ),
          ),
        ],
      ),

      /*
      NaigationBar formada por:
            - Dos contonedores:
                  - En el primero aparece el precio del producto y la cantidad de unidades (además de botones - y + para modifcar la cantidad unidades)
                  - En el segundo a la izquierda, aparece un botón para dar Me Gusta al plato y la derecha un botón con el precio del plato que pone "Añadir al carrito"
       */

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Icono - reduce la cantidad al ser pulsado

              GestureDetector(
                onTap: () {
                  Get.find<ProductController>().setQuantity(false, productItem);
                },
                child: Container(
                  width: 40,
                  height: 40,

                  child: Center(
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                  decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: Colors.grey.withOpacity(0.1))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor),
                ),
              ),
              SizedBox(width: 40),

              // Precio y cantidad de unidades del plato

              GetBuilder<ProductController>(builder: (_) {
                return BigText(
                  text: (productItem.price.round()).toString()+"\€" +
                      " X " +
                      Get.find<ProductController>().certainItems.toString(),
                  color: AppColors.mainBlackColor,
                  size: 26,
                );
              }),
              SizedBox(width: 40),

              // Icono + aumenta la cantidad al ser pulsado

              GestureDetector(
                onTap: () {
                  Get.find<ProductController>().setQuantity(true, productItem);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: Colors.grey.withOpacity(0.1))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.detailFoodImgPad,
                right: Dimensions.detailFoodImgPad),
            height: Dimensions.buttomButton,
            padding: EdgeInsets.only(
                top: Dimensions.padding20,
                bottom: Dimensions.padding20,
                left: Dimensions.padding20,
                right: Dimensions.padding20),
            child: Row(
              children: [

                // Icono Me Gusta (función no implementada)

                Expanded(child: Container()),

                // Botón de añadir al carrito.
                // Al pulsar en él se añaden tantos productos como haya indicado el usuario.

                GetBuilder<ProductController>(builder: (_) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        Get.find<ProductController>().addItem(productItem);
                        Get.snackbar("Producto", "Añadido con éxito");
                      },
                      child: BigText(
                        text: (productItem.price.round()).toString()+"\€"+ " | Añadir",
                        color: Colors.white,
                      ),
                    ),
                    padding: EdgeInsets.all(Dimensions.padding20),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.padding20),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              //spreadRadius: 3,
                              color: AppColors.mainColor.withOpacity(0.3))
                        ]),
                  );
                })
              ],
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.padding40),
                  topRight: Radius.circular(Dimensions.padding40),
                )),
          )
        ],
      ),
    );
  }
}
