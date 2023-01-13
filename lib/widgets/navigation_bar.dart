import 'package:flutter/material.dart';
import 'package:personal/pages/expense/expense_home.dart';
import 'package:personal/pages/fuel/fuel_home.dart';
import 'package:personal/services/auth_services.dart';
import 'package:personal/services/user_ops_services.dart';
import 'package:personal/widgets/nav_item.dart';
import 'package:provider/provider.dart';

class PersonalNavBar extends StatefulWidget {
  const PersonalNavBar({super.key});

  @override
  State<PersonalNavBar> createState() => _PersonalNavBarState();
}

class _PersonalNavBarState extends State<PersonalNavBar> {
  @override
  Widget build(BuildContext context) {
    GlobalKey userAccountDrawerKey = GlobalKey<NavigatorState>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            key: userAccountDrawerKey,
            accountName: Text(Provider.of<AuthServices>(context, listen: false)
                    .currentLoggedInUser!
                    .displayName ??
                "null"),
            accountEmail: Text(
                (Provider.of<AuthServices>(context, listen: false)
                        .currentLoggedInUser!
                        .email) ??
                    "null"),
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
