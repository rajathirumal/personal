import 'package:flutter/material.dart';
import 'package:personal/pages/expense/expense_home.dart';
import 'package:personal/pages/fuel/fuel_home.dart';
import 'package:personal/widgets/nav_item.dart';

class PersonalNavBar extends StatefulWidget {
  const PersonalNavBar({super.key});

  @override
  State<PersonalNavBar> createState() => _PersonalNavBarState();
}

class _PersonalNavBarState extends State<PersonalNavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text("data"),
            accountEmail: Text("rajathirumal98@gmail.com"),
            currentAccountPicture: CircleAvatar(),
            otherAccountsPictures: [
              CircleAvatar(),
              CircleAvatar(),
            ],
          ),
          PersonalNavItem(
              iconRep: Icon(Icons.home),
              toPage: ExpenseHome(),
              displayText: "ALL YOUR EXPENSES ₹₹₹"),
          PersonalNavItem(
            iconRep: Icon(Icons.face),
            toPage: FuelHome(),
            displayText: "MONEY ON FUEL ₹₹₹",
          ),
          Divider(),
        ],
      ),
    );
  }
}
