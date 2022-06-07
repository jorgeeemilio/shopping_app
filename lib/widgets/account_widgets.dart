// Clase para formae el icono de perfil.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/widgets/big_text.dart';

class AccountWidgets extends StatelessWidget {

  // Tiene dos variables.
  // AppIcon --> Clase para formar un icono.
  // BigText --> Clase para formar un texto grande.

  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String text;
  const AccountWidgets(this.text, {Key? key,
    this.iconColor=Colors.white, required this.icon,
    required this.backgroundColor,}) : super(key: key);

  /*
  Este widget devuelve un Contenedor con las siguientes características:
      - padding --> Tiene un padding de 20 a la izquierda y de 10 por arriba y por abajo.
      - child: Row --> Tiene una final como hijo que contiene un icono, un espaciado y un texto grande.
      - decoration: BoxDecoration --> Este widget tiene un estilo propio para dar sensación de sombreado natural.
   */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20,top: 10, bottom: 10),

      margin: const EdgeInsets.only(left: 0, right: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.05),
            offset: Offset(2, 1)
          )
        ]
      ),
      child: Row(
        children: [
          Container(

            width: 50,
            height: 50,
            child: Icon(icon, color:iconColor,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: backgroundColor
            ),
          ),
          SizedBox(width: 20,),
          BigText(text: text, color: AppColors.mainBlackColor)
        ],
      ),
    );
  }
}
