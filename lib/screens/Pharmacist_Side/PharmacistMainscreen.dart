import 'package:flutter/material.dart';
import 'package:project/screens/Normal_User_Side/account.dart';
import 'package:project/screens/Normal_User_Side/homescreen.dart';
import 'package:project/screens/Normal_User_Side/order.dart';
import 'package:project/screens/Normal_User_Side/payment.dart';
import 'package:project/screens/Normal_User_Side/shop.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/screens/Pharmacist_Side/PharmacistChat.dart';
import 'package:project/screens/Pharmacist_Side/PharmacistManagement.dart';
import 'package:project/screens/Pharmacist_Side/PharmacistOrder.dart';
import 'package:project/screens/Pharmacist_Side/PharmacistProducts.dart';

class PharmacistMainscreen extends StatefulWidget {
  const PharmacistMainscreen({super.key});

  @override
  State<PharmacistMainscreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<PharmacistMainscreen> {
  int _selectedIndex = 0;

  final _screens = [
    PharmacistOrder(),
    PharmacistProducts(),
    PharmacistChat(),
    PharmacistManagement()
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 59, 182, 162),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house, size: 24),
              label: 'คำสั่งซื้อ'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.shop, size: 24),
              label: 'คลังสินค้า'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.message, size: 24), label: 'แชท'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar, size: 24),
              label: 'จัดการร้าน'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
