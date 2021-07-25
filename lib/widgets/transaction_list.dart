import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionHandler;

  TransactionList(this.transactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions Added',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (cxt, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                elevation: 5,
                child: ListTile(
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.title),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          'R${transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransactionHandler(transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransactionHandler(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
