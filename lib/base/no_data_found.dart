// Clase para que cuango el usuario no tengas ningún producto en el carrito le salga una foto de aviso.
// Esta clase también se usa para cuando el usuario no tiene historial de compra.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/uitls/styles.dart';

class NoDataScreen extends StatelessWidget {

  // Tiene dos variables.
  // String text --> "Your cart is empty!" y "You didn't buy anything so far!"
  // String imgPath --> La ruta de la imagen.

  final String text;
  final String imgPath;
  NoDataScreen({required this.text, this.imgPath="assets/image/empty_cart.png"});

  /*
  mainAxisAlignment y crossAxisAlignment se usan para centrar la foto.
  height y widht para definir las dimensiones de la foto.
  SizedBox para crear un espaciado entre la foto y el texto.
  fontSize, color pary textAlign para darle estilo al texto.
   */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Image.asset(
          imgPath,
          width: MediaQuery.of(context).size.height*0.22,
          height: MediaQuery.of(context).size.height*0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03),
        Text(
          text,
          style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.0175,
              color: Theme.of(context).disabledColor),/*robotoMedium.copyWith(fontSize:
          MediaQuery.of(context).size.height*0.0175,
              color: Theme.of(context).disabledColor)*/
          textAlign: TextAlign.center,
        ),

      ]),
    );
  }
}
