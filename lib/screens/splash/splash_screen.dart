// Pantalla de Carga

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/location_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/home/home_page.dart';
import 'package:get/get.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';

import '../../controllers/splash_controller.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/*
Esta clase se ejecuta al comienzo del programa
Esta formada por:
      - El icono de la aplicación (el cual tiene una animación y tarda varios segundos en aparecer)
      - El título de la aplicación
La función de esta pantalla es cargar el contendio de la aplicación (fotos de platos), mientras proporciona al cliente una profesional Bienvenida
 */

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  // Dos variables late (se inicializan después de declararse) para dar animación al icono

  late Animation<double> animation;
  late AnimationController _controller;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  @override
  dispose() {
    _controller.dispose();
    _onConnectivityChanged.cancel();
    super.dispose();
  }
  @override

  // Hace uso de los controladores PopularProductController y RecommendedProductController para cargar los platos

  Future<void>_loadResources(bool reload)async {
    await  Get.find<ProductController>().getRecommendedProductList(reload);
    await  Get.find<PopularProduct>().getPopularProductList(reload);
    if(Get.find<AuthController>().isLoggedIn()) {
      await Get.find<UserController>().getUserInfo();
      await Get.find<LocationController>().getAddressList();
      if(Get.find<LocationController>().addressList.isNotEmpty){
        var address = Get.find<LocationController>().addressList[0];
        await Get.find<LocationController>().saveUserAddress(address);
        print("I am in splash page ............");
      }
    }
  }
  void _removeResource(){
     Get.find<CartController>().clear();
     Get.find<CartController>().removeCartSharedPreference();
  }

  /*
    La animación del icono dura dos segundos
    Consiste en que va apareciendo poco a poco
    En concreto, esta animación se llama Curves.linear, pero hay muchas más
     */

  void initState() {
    super.initState();
    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        print("second time");
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection': 'connected',
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {

          // Pasados los tres segundos desde el comienzo de la aplicación se redirige a la pantalla principal

          Timer(Duration(seconds: 3),

                  ()=>Get.offNamed(RouteHelper.getInitialRoute())
          );
        }
      }
      _firstTime = false;
    });

    //_loadResources(true);
    // _removeResource();
    _controller =
    new AnimationController(vsync: this, duration: Duration(seconds: 2))..forward()
    ;
    animation = new CurvedAnimation(parent: _controller,
        curve: Curves.linear);
    _route();
  }
  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(Duration(seconds: 3), () async {
          int _minimumVersion = 0;

              if (Get.find<AuthController>().isLoggedIn()) {
                 // Get.find<AuthController>().updateToken();

                  Get.offNamed(RouteHelper.getInitialRoute());
                  print("my image is "+'${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}'
                      '/${(Get.find<UserController>().userInfoModel != null && Get.find<AuthController>().isLoggedIn()) ? Get.find<UserController>().userInfoModel?.image : ''}');
              } else {

                  Get.offNamed(RouteHelper.getSignInRoute());

              }

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // Devuelve Scaffold (Clase que implementa los materiales básicos de diseño de una estrucutra layout, conocidos como "material design").

    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        // Se añaden las dos fotos: Logo y Título

        children: [
          ScaleTransition(
            scale: animation,
              child: Center(child: Image.asset("img/logo part 1.png", width:Dimensions.SPLASH_IMG_WIDTH*1.5))),
          Center(child: Image.asset("img/logo part 2.png", width:Dimensions.SPLASH_IMG_WIDTH*1.5,)),
        ],
      ),
    );
  }
}
