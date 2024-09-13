import 'package:flutter/material.dart';
import 'package:project/screens/Normal_User_Side/account.dart';
import 'package:project/screens/Normal_User_Side/homescreen.dart';
import 'package:project/screens/Normal_User_Side/order.dart';
import 'package:project/screens/Normal_User_Side/payment.dart';
import 'package:project/screens/Normal_User_Side/shop.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final _screens = [homescreen(), shop(), payment(), order(), account()];
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
              label: 'หน้าหลัก'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.shop, size: 24), label: 'ร้านยา'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.moneyBill, size: 24),
              label: 'ชำระเงิน'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.fileInvoiceDollar, size: 24),
              label: 'คำสั่งซื้อ'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 24), label: 'บัญชี'),
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
