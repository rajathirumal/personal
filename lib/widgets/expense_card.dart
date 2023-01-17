import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:personal/models/add_expense_model.dart';

class ExpenseCard extends StatefulWidget {
  final List<SingleExpense> expense;
  final int index;
  const ExpenseCard({
    Key? key,
    required this.expense,
    required this.index,
  }) : super(key: key);

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  @override
  Widget build(BuildContext context) {
    final int _ind = widget.index;
    final List<SingleExpense> _exp = widget.expense;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: [
            ExpansionPanelRadio(
              value: _exp[_ind].expenseID,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Date:",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _exp[_ind].timestamp.split(" ")[0].toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      const Text(
                        "Spent:",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        (double.parse(_exp[_ind].price) *
                                    int.parse(_exp[_ind].count))
                                .toString() +
                            " ₹",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Item:",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            _exp[_ind].itemName.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.05,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Location:",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            _exp[_ind].location.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.05,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Friends:",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            _exp[_ind].friends.map((f) => "$f ").toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.05,
                    ),
                    Row(
                      children: [
                        const Text(
                          "item count:",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            _exp[_ind].count,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "item price:",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            "${_exp[_ind].price} ₹",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //   child: Card(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    //       child:
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           // Row 1
    //           Row(
    //             children: [
    //               const Text(
    //                 "Date:",
    //                 style: TextStyle(fontSize: 15),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Text(
    //                 _exp[_ind].timestamp.split(" ")[0].toString(),
    //                 style: const TextStyle(fontSize: 15),
    //               ),
    //               const Spacer(),
    //               const Text(
    //                 "Spent:",
    //                 style: TextStyle(fontSize: 15),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Text(
    //                 "${_exp[_ind].price} ₹",
    //                 style: const TextStyle(fontSize: 15),
    //               ),
    //             ],
    //           ),
    //           const Divider(
    //             thickness: 0.5,
    //           ),
    //           // Row 2
    //           Row(
    //             children: [
    //               const Text(
    //                 "Item:",
    //                 style: TextStyle(fontSize: 15),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Flexible(
    //                 child: Text(
    //                   _exp[_ind].itemName.toString(),
    //                   style: const TextStyle(fontSize: 15),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const Divider(
    //             thickness: 0.5,
    //           ),
    //           // Row 3
    //           Row(
    //             children: [
    //               const Text(
    //                 "Location:",
    //                 style: TextStyle(fontSize: 15),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Flexible(
    //                 child: Text(
    //                   _exp[_ind].location.toString(),
    //                   style: const TextStyle(fontSize: 15),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const Divider(
    //             thickness: 0.5,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
