// Pantalla de Iniciar Sesión

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/base/custom_loader.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/auth/sign_up_page.dart';
import 'package:get/get.dart';
import 'package:shopping_app/uitls/styles.dart';
import 'package:shopping_app/widgets/big_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

    /*
    Dos variables controladores.
    Teléfono y contraseña.
     */

  var _phoneController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Devuelve Scaffold (Clase que implementa los materiales básicos de diseño de una estrucutra layout, conocidos como "material design").

    return Scaffold(

      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder:( authController){

        // SingleChildScrollView para arreglar un fallo de texturas que daba al pinchar en uno de los campos.

        return  ! authController.isLoading?SingleChildScrollView(

          // Físicas añadidas para que se puede scrollear adecuadamente.

        physics: BouncingScrollPhysics(),
          child: Column(
                    children: [

                      // Logo de la aplicación

                      Container(
                        width: w,
                        height: h*0.2,
                        margin:  EdgeInsets.only(top:40, left: 40, right: 40, bottom: 20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "img/logo part 1.png"
                                ),
                                fit: BoxFit.fitHeight
                            )
                        ),
                      ),

                      // Zona de bienvenida

                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        width: w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hola",
                              style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "Inicie sesión en su cuenta",
                              style: TextStyle(
                                  fontSize: 20,
                                  color:Colors.grey[500]
                              ),
                            ),
                            SizedBox(height: 50,),
                            Container(
                              decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(1, 1),
                                        color:Colors.grey.withOpacity(0.2)
                                    )
                                  ]
                              ),

                              // Teléfono

                              child: TextField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                    hintText: "Teléfono",
                                    prefixIcon: Icon(Icons.mobile_screen_share, color:AppColors.mainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:Colors.white,
                                            width: 1.0
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:Colors.white,
                                            width: 1.0
                                        )
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(1, 1),
                                        color:Colors.grey.withOpacity(0.2)
                                    )
                                  ]
                              ),

                              // Contraseña

                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Contraseña",
                                    prefixIcon: Icon(Icons.password, color:AppColors.mainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:Colors.white,
                                            width: 1.0
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:Colors.white,
                                            width: 1.0
                                        )
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    )
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: (){
                          _login(authController);
                        },
                        child: Container(
                          width: w*0.5,
                          height: h*0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.mainColor
                          ),

                          // Iniciar sesión

                          child:Center(
                            child: BigText(
                              text: 'Iniciar sesión',
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),

                      // No tienes una cuenta?

                      RichText(text: TextSpan(
                          text:"¿No tienes una cuenta?",
                          style: TextStyle(
                              color:Colors.grey[500],
                              fontSize: 20
                          ),
                          children: [

                            // Crear

                            TextSpan(
                                text:" Crear",
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
                            )
                          ]
                      )
                      )
                    ],
                  ),
        ):CustomLoader();


      }),
    );
  }

  void _login(AuthController authController ) async {
    String _phone = _phoneController.text.trim();
    String _password = _passwordController.text.trim();

    bool _isValid = GetPlatform.isWeb ? true : false;

    // Comprobaciones

    if (_phone.isEmpty) {
      Get.snackbar("Teléfono", "Escriba su teléfono");
    }else if (_password.isEmpty) {
      Get.snackbar("Contraseña", "Escriba su contraseña");
    }else if (_password.length < 6) {
      Get.snackbar("Contraseña", "Más de 6 caracteres");
    }else {
      authController.login(_phone, _password).then((status) async {
        if (status.isSuccess) {
          authController.saveUserNumberAndPassword(_phone, _password);
          String _token = status.message.substring(1, status.message.length);

            Get.toNamed(RouteHelper.getInitialRoute());

        }else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}
