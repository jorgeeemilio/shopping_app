// Pantalla del Perfil del Ususario

import 'package:flutter/material.dart';
import 'package:shopping_app/base/go_to_sign_in_page.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/location_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/widgets/account_widgets.dart';
import 'package:get/get.dart';

import '../../base/custom_image.dart';
import '../../controllers/splash_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  _loadUserInfo() async {
    await Get.find<LocationController>().getAddressList();
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      var address = Get.find<LocationController>().addressList[0];
      await Get.find<LocationController>().saveUserAddress(address);
      
    } else {
      print("addresslist is empty");
    }
  }

  @override
  Widget build(BuildContext context) {

    // Devuelve Scaffold (Clase que implementa los materiales básicos de diseño de una estrucutra layout, conocidos como "material design").

    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<LocationController>().addressList.isEmpty) {
      Get.find<UserController>().getUserInfo();
      // Get.find<LocationController>().getAddressList();
      _loadUserInfo();
      print(".........");
    } else {
      print("empty" + _isLoggedIn.toString());
    }

    /*
      En la parte de arriba se encuentra un AppBar con el título de Profile.
      El body está compuesto por un contenedor:
          - El ancho está modificado para que rellene toda la pantalla.
          - El margen también está modificado.
          - Tiene una columna como hijo, formada por seis hijos:
              - AppIcon:
                  - Es el icono principal del perfil del usuario (se debería implementar la opción de cambiar la foto).
              - AccountWidget (con un AppIcon):
                  - Teléfono del usuario.
              - AccountWidget:
                  - Correo del usuario.
              - AccountWidget (con un AppIcon):
                  - Domicilio del usuario.
              - AccountWidget (con un AppIcon):
                  - Bandeja de entrada de mensajes.
              - AccountWidget (con un AppIcon):
                  - Logout (Cerrar Sesión).
          - Todos estos widgets se componen de una serie de características:
              - icon: icono.
              - backgroundColor: color del fondo.
              - iconColor: color del icono.
              - iconSize: tamaño del icono.
              - size: tamaño del contorno.
       */

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        backgroundColor: AppColors.mainColor,
      ),
     // backgroundColor: Colors.white10,
      body: Container(
        color:Colors.white10,
        margin: Dimensions.isWeb
            ? EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                right: Dimensions.MARGIN_SIZE_EXTRA_LARGE)
            : EdgeInsets.all(0),
        child: GetBuilder<UserController>(builder: (userController) {
          var path = '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}'
              '/${(Get.find<UserController>().userInfoModel != null && Get.find<AuthController>().isLoggedIn()) ? Get.find<UserController>().userInfoModel?.image : ''}';
          return (_isLoggedIn)
              ?
                   Column(

                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          child:ClipOval(
                              child: CustomImage(
                                image:path,
                                height: 150,
                                width: 150, fit: BoxFit.cover, placeholder: '',
                              )
                          ),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              color: AppColors.mainColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [

                                  SizedBox(
                                    height: 20,
                                  ),
                                  AccountWidgets(
                                      userController.userInfoModel!.fName,
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AccountWidgets(
                                      userController.userInfoModel!.phone,
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.yellowColor),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AccountWidgets(
                                      userController.userInfoModel!.email,
                                      icon: Icons.email,
                                      backgroundColor: AppColors.yellowColor),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GetBuilder<LocationController>(
                                      builder: (locationController) {
                                    if (_isLoggedIn &&
                                        Get.find<LocationController>()
                                            .addressList
                                            .isEmpty) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteHelper.getAddAddressRoute());
                                        },
                                        child: AccountWidgets(
                                            "Rellene su domicilio",
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteHelper.getAddAddressRoute());
                                        },
                                        child: AccountWidgets("Domicilio",
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.yellowColor),
                                      );
                                    }
                                  }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .isLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>()
                                              .clearCartList();
                                          Get.find<LocationController>()
                                              .clearAddressList();
                                          Get.offAllNamed(
                                              RouteHelper.getInitialRoute());
                                        }
                                      },
                                      child: AccountWidgets("Cerrar sesión",
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.offNamed(RouteHelper.getUpdateProfile());
                                      },
                                      child: AccountWidgets("Editar",
                                          icon: Icons.edit,
                                          backgroundColor: Colors.redAccent)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )

              : GoToSignInPage();

        }),
      ),
    );
  }
}
