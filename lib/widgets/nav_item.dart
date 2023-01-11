import 'package:flutter/material.dart';

class PersonalNavItem extends StatelessWidget {
  final Widget toPage;
  final Widget iconRep;
  final String displayText;
  const PersonalNavItem({
    Key? key,
    required this.toPage,
    required this.iconRep,
    required this.displayText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: iconRep,
        title: Center(child: Text(displayText)),
        onTap: () {
          Navigator.of(context).pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => toPage,
            ),
          );
        },
      ),
    );
  }
}
