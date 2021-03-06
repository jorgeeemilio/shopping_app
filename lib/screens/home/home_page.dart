// Pantalla de Bienvenida que posee el Menú de Navegación

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/colors.dart';
import 'package:shopping_app/screens/account/account_page.dart';
import 'package:shopping_app/screens/cart/cart_history.dart';
import 'package:shopping_app/screens/home/home_page_body.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Se inicializa el índice a 0
  // Cuando la aplicación se ejecuta el índice es 0.

  int _selectedIndex=0;

  // Las cuatro páginas del Menu Navigation

  List pages=[
    HomePageBody(),
    CartHistory(),
    AccountPage(),
  ];

// Para actualizar el índice

  void onTap(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9fa),
        body:pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTap,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [

          // Inicio

          BottomNavigationBarItem(icon: Icon(Icons.home_filled),
          label: "home"
          ),

          // Historial del carrito

          BottomNavigationBarItem(icon: Icon(Icons.hourglass_full),
              label: "home"
          ),

          // Perfil

          BottomNavigationBarItem(icon: Icon(Icons.person),
              label: "home"

          )
        ],
      ),

    );

  }
}
