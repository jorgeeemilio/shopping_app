// Pantalla de Crear una Cuenta

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/custom_loader.dart';
import 'package:shopping_app/base/custom_snackbar.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/controllers/auth_controller.dart';
import 'package:shopping_app/models/signup_body.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';
class SignUpPage extends StatelessWidget {
   SignUpPage({Key? key}) : super(key: key);

   /*
    Cuatro variables controladores.
    Email, contraseña, nombre y teléfono.
     */

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    /*
    List images =[
      "g.png",
      "t.png",
      "f.png"
    ];
     */

    double w = MediaQuery.of(context).size.width*1.25;
    double h = MediaQuery.of(context).size.height*1.25;

    // Devuelve Scaffold (Clase que implementa los materiales básicos de diseño de una estrucutra layout, conocidos como "material design").

    return Scaffold(

      backgroundColor: Colors.white,
      body:GetBuilder<AuthController>(builder: (authController) {
        return

          // SingleChildScrollView para arreglar un fallo de texturas que daba al pinchar en uno de los campos.

         !authController.isLoading?  SingleChildScrollView(

           // Físicas añadidas para que se puede scrollear adecuadamente.

         physics: BouncingScrollPhysics(),
             child: Column(
                children: [

                  // Logo de la aplicación

                  Container(
                    width: w,
                    height: h * 0.25,
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: h * 0.05,),
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            radius: 80,
                            backgroundImage: AssetImage(
                                "img/logo part 1.png"
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Email, contraseña, telefono y nombre

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 20,),
                        AppTextField(hintText:"Email", textController:emailController, icon: Icons.email,),
                        SizedBox(height: 20,),
                        AppTextField(hintText:"Contraseña", textController:passwordController, icon:Icons.password_sharp),
                        SizedBox(height: 20,),
                        AppTextField(hintText:"Teléfono", textController:phoneController, icon:Icons.phone),
                        SizedBox(height: 20,),
                        AppTextField(hintText:"Nombre", textController:nameController, icon:Icons.person),
                        SizedBox(height: 40,),


                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _register(authController);
                    },
                    child: Container(
                      width: w * 0.5,
                      height: h * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.mainColor
                      ),

                      // Crear cuenta

                      child: Center(
                        child: BigText(
                          text:"Crear cuenta",
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
           ):CustomLoader();

      }));
    }

  void _register(AuthController authController) async {
    String _firstName = nameController.text.trim();
    String _email = emailController.text.trim();
    String _number = phoneController.text.trim();
    String _password = passwordController.text.trim();


    if (_firstName.isEmpty) {
      showCustomSnackBar("Escriba su nombre", title:"Nombre");

    }else if (_email.isEmpty) {
      showCustomSnackBar("Escriba su Email", title:"Email");
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar("Escriba un Email correcto", title:"Email");
    }else if (_number.isEmpty) {
      showCustomSnackBar("Escriba su Teléfono móvil", title:"Teléfono móvil");
    }else if (_password.isEmpty) {
      showCustomSnackBar("Escriba su contraseña", title:"Contraseña");
    }else if (_password.length < 6) {
      showCustomSnackBar("Escriba mínimo 6 caracteres", title:"Contraseña");

    }else {
      SignUpBody signUpBody = SignUpBody(fName: _firstName,
          email: _email,
          phone: _number, password: _password);
      authController.registration(signUpBody).then((status) async {
        if (status.isSuccess) {
            print("success registration");
            Get.toNamed(RouteHelper.getAddAddressRoute());
        }else {
          Get.snackbar("Error", "El correo o teléfono ya está en uso");

        }
      });
    }
  }
}
