// Clase para formar los iconos seguidos de un texto que componen la aplicación.

import 'package:flutter/cupertino.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class IconAndTextWidget extends StatelessWidget {

  /*
  Tres variables.
  icon --> icono.
  text --> texto.
  iconColor --> color del icono.
   */

  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  IconAndTextWidget({Key? key,
    required this.text,
    this.color=const Color(0xFF76c5bb),
    this.iconColor= const Color(0xFF93ddd4),
    required this.icon}) : super(key: key);

  /*
  Este widget devuelve una fila con las siguientes características:
      - Posee varios hijos:
          - El icono.
          - Un espaciado de 5 de ancho.
          - Un texto pequeño.
   */

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color:iconColor),
        SizedBox(width: 5,),
        TextWidget(text: text, color: color)
      ],
    );
  }
}
