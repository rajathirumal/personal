import 'package:flutter/material.dart';
import 'package:personal/services/auth_services.dart';
import 'package:provider/provider.dart';

class PersonalHome extends StatefulWidget {
  const PersonalHome({super.key});

  @override
  State<PersonalHome> createState() => _PersonalHomeState();
}

enum MenuOptions {
  logout,
}

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
              ];
            },
          )
        ],
      ),
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
          content: const Text(
              'If you are trying to add a fuel, please navigate to the add fuel page,\n\n'
              'Simply click on "Take me to fuel page" '),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Take me to fuel page'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Other expense'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
