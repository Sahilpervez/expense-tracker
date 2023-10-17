import 'package:expense_tracker/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.userTranx,this.deletetransaction, this._islandscape, {super.key} );
  final List<Transaction> userTranx;
  final Function deletetransaction;

  final bool _islandscape ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppLayout.getScreenHeight() * 0.58,
      child: (userTranx.isEmpty)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20),
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        fontFamily: 'Quicksand',
                      ),
                ),
                Text(
                  "Wow!! You saved this week",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        fontFamily: 'Quicksand',
                      ),
                ),
                Gap(10),
                Image.asset(
                  "assets/Images/purple_wallet_small.png",
                  scale: (_islandscape) ? 3 : 1.4,
                  fit: BoxFit.contain,
                )
              ],
            )
          : ListView.builder(
              padding:EdgeInsets.only(top:10,bottom: 50),
              itemCount: userTranx.length,
              itemBuilder: (cntx, idx) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text("\$${userTranx[idx].amount}"),
                        ),
                      ),
                    ),
                    title: Text(
                      "${userTranx[idx].title}",
                      style: TextStyle(fontFamily: 'OpenSans',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,),
                    ),
                    subtitle: Text(
                      "${DateFormat.yMMMd().format(userTranx[idx].date)} - ${DateFormat.jm().format(userTranx[idx].date)}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deletetransaction(userTranx[idx].id);
                      },
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
                // return Card(
                //   color: Color(0xfff9e7f8),
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           horizontal: 15,
                //           vertical: 10,
                //         ),
                //         padding: EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             width: 2,
                //             color: Colors.purple,
                //           ),
                //         ),
                //         child: Text(
                //           "\$ ${userTranx[idx].amount.toStringAsFixed(2)}",
                //           style: TextStyle(
                //             color: Colors.purple,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             userTranx[idx].title,
                //             // style: TextStyle(
                //             //   fontSize: 16,
                //             //   fontWeight: FontWeight.bold,
                //             // ),
                //             style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                //           ),
                //           Text(
                //             "${DateFormat.yMMMd().format(userTranx[idx].date)} - ${DateFormat.jm().format(userTranx[idx].date)}",
                //             style: TextStyle(color: Colors.grey),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              },
              // scrollDirection: Axis.horizontal,
              // children: userTranx.map((tranx) {
              //   return Card(
              //     child: Row(
              //       children: [
              //         Container(
              //           margin: EdgeInsets.symmetric(
              //             horizontal: 15,
              //             vertical: 10,
              //           ),
              //           padding: EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               width: 2,
              //               color: Colors.purple,
              //             ),
              //           ),
              //           child: Text(
              //             "\$${tranx.amount}",
              //             style: TextStyle(
              //               color: Colors.purple,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //             ),
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               tranx.title,
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.bold),
              //             ),
              //             Text(
              //               "${DateFormat.yMMMd().format(tranx.date)} - ${DateFormat.jm().format(tranx.date)}",
              //               style: TextStyle(color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   );
              // }).toList(),
            ),
    );
  }
}
