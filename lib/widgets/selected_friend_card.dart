import 'package:flutter/material.dart';

class SelectedFriendCard extends StatefulWidget {
  final String friendName;
  const SelectedFriendCard({
    super.key,
    required this.friendName,
  });
  // const SelectedFriendCard({super.key});

  @override
  State<SelectedFriendCard> createState() => _SelectedFriendCardState();
}

class _SelectedFriendCardState extends State<SelectedFriendCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.black26,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.friendName),
        ),
      ),
    );
    //Text(widget.friendName);
  }
}
