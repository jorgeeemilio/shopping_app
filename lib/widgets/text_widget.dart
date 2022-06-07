// Clase para formar los textos pequeños que componen la aplicación.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';

class TextWidget extends StatelessWidget {

  /*
  Cuatro variables, ?  significa opcional.
  color --> color del texto.
  text --> texto.
  size --> tamaño.
  height --> espaciado entre cada línea.
   */

  final String text;
  final Color color;
  double size;
  double height;
   TextWidget({Key? key,
  required this.text,
    required this.color,
    this.size=0,
     this.height=1.2,
  }) : super(key: key);

  /*
  Este widget devuelve un texto con las siguientes características:
      - El texto.
      - Un estilo, formado por:
          - Fuente, color y tamaño.
   */

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color:color,
        fontSize:size==0?Dimensions.font18:size,
        height: height
      ),
    );
  }
}
