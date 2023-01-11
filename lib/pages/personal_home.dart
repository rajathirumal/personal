import 'package:flutter/material.dart';
import 'package:personal/pages/expense/add_expense.dart';
import 'package:personal/pages/expense/expense_home.dart';
import 'package:personal/pages/fuel/add_fuel.dart';
import 'package:personal/pages/fuel/fuel_home.dart';
import 'package:personal/services/auth_services.dart';
import 'package:personal/widgets/navigation_bar.dart';
import 'package:provider/provider.dart';

class PersonalHome extends StatefulWidget {
  const PersonalHome({super.key});

  @override
  State<PersonalHome> createState() => _PersonalHomeState();
}

enum MenuOptions { logout, userProfile }

class _PersonalHomeState extends State<PersonalHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<MenuOptions>(
            onSelected: (value) {
              switch (value) {
                case MenuOptions.logout:
                  Provider.of<AuthServices>(context, listen: false).signOut();
                  break;
                case MenuOptions.userProfile:
                  // Provider.of<AuthServices>(context, listen: false).signOut();
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<MenuOptions>>[
                // PopupMenuItem(
                //   value: MenuOptions.analytics,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: const [
                //       Icon(
                //         Icons.analytics_outlined,
                //         color: Colors.black,
                //       ),
                //       Text("Analysis"),
                //     ],
                //   ),
                // ),
                // const PopupMenuDivider(height: 1),
                PopupMenuItem(
                  value: MenuOptions.logout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      Text("Logout"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: MenuOptions.userProfile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                      ),
                      Text("User profile"),
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
      drawer: PersonalNavBar(),
      body: const Center(
        child: Text("Personal home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _dialogBuilder(context),
        // () {
        //   // Provider.of<AuthServices>(context,listen: false).signOut();
        //   showDialog(context: context, builder: );

        // },
        label: const Text('Add expense'),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adding expense !?'),
          content: const Text('Keep track of your expenses \n\n'
              'What sort of expense are you trying yo make ?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Fuel expense'),
              onPressed: () async {
                Navigator.of(context).pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FuelHome(),
                  ),
                );
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFuel(),
                  ),
                );
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Other expense'),
              onPressed: () async {
                Navigator.of(context).pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpenseHome(),
                  ),
                );
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddExpense(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
