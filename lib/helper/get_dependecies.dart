// Clase para definir las dependencias del proyecto.

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/location_controller.dart';
import 'package:shopping_app/controllers/popular_product.dart';
import 'package:shopping_app/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controllers/search_product_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/data/api/api_client.dart';
import 'package:shopping_app/data/repos/auth_repo.dart';
import 'package:shopping_app/data/repos/cart_repo.dart';
import 'package:shopping_app/data/repos/location_repo.dart';
import 'package:shopping_app/data/repos/order_controller.dart';
import 'package:shopping_app/data/repos/order_repo.dart';
import 'package:shopping_app/data/repos/popular_product_repo.dart';
import 'package:shopping_app/data/repos/product_repo.dart';
import 'package:shopping_app/data/repos/search_product_repo.dart';
import 'package:shopping_app/data/repos/user_repo.dart';
import 'package:shopping_app/uitls/app_constants.dart';

import '../controllers/splash_controller.dart';
import '../data/repos/splash_repo.dart';

Future<void> init() async {

  // Una sola variable --> sharedPreferences (para guardar información localmente)

  final sharedPreference = await SharedPreferences.getInstance();

  // SharedPreferences

  Get.lazyPut(() => sharedPreference);

  // ApiClient

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Pantalla de carga

  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

  // Repositorios

  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => SearchProductRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controladores

  Get.lazyPut(() => SplashController(splashRepo: Get.find()));

  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));

  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => PopularProduct(popularProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo:Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => SearchProductController(searchProductRepo: Get.find()));
}