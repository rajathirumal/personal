import 'package:flutter/material.dart';

class PersonalHome extends StatefulWidget {
  const PersonalHome({super.key});

  @override
  State<PersonalHome> createState() => _PersonalHomeState();
}

class _PersonalHomeState extends State<PersonalHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
