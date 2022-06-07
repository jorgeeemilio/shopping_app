// Clase para formar los textos grandes que componen la aplicación.

import 'package:flutter/cupertino.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/uitls/styles.dart';

class BigText extends StatelessWidget {

  /*
  Cuatro variables.
  color --> color del gran texto, ? significa opcional
  text --> texto
  size --> tamaño
  overFlow --> desbordamiento (cuando no cabe el texto en una línea --> ...)
  */

  final String text;
  final Color color;
  double size;
  TextOverflow overFlow;
  BigText({Key? key,
    required this.text,
    required this.color,
    this.size=0,
    this.overFlow=TextOverflow.ellipsis
  }) : super(key: key);

  /*
  Este widget devuelve un texto con las siguientes características:
      - El texto definido arriba.
      - Una sola línea.
      - Desbordamiento.
      - Estilo:
          - Fuente, color y tamaño.
   */

  @override
  Widget build(BuildContext context) {
    return Text(

      text,
      maxLines: 1,
      overflow: overFlow,
      softWrap: false,
      style: TextStyle(
        fontFamily: 'Roboto',
        color:color,
        fontSize:size==0?Dimensions.font20:size,
        fontWeight: FontWeight.w400,
      )
     // robotoRegular,
    );
  }
}
