// Clase Principal del Programa.

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/food/detail_food.dart';
import 'package:shopping_app/screens/food/more_food.dart';
import 'package:shopping_app/uitls/scroll_behavior.dart';
import 'components/colors.dart';
import 'helper/get_dependecies.dart' as dep;
import 'package:get/get.dart';

// Primero comprobamos que las dependencias se han cargado correctamente.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartsData();
      return  GetBuilder<ProductController>(builder:(_){
          return GetBuilder<PopularProduct>(builder: (_){
            return GetMaterialApp(
              scrollBehavior: AppScrollBehavior(),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: AppColors.mainColor,
                fontFamily: "Lato",
              ),

              /*
              Cargamos la clase SplashPage() --> pantalla de carga que llama a HomePage() --> formado por un menú de navegación dividido en: (PROVISIONAL)
                - Inicio con los platos
                - Pedidos
                - Historial del carrito
                - Perfil
               */

              initialRoute: RouteHelper.getSplashRoute(),
              getPages: RouteHelper.routes,
              defaultTransition: Transition.topLevel,
            );
          });
        });

  }
}
