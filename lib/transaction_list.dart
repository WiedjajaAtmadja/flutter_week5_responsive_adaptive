import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTx;

  const TransactionList(this._transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? Column(
            children: [
              Text('No transaction added yet!',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover))
            ],
          )
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteTx(_transactions[index].id),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(DateFormat('dd MMM y, hh:mm:ss')
                      .format(_transactions[index].date)),
                  trailing: Text(
                    NumberFormat('Rp #000', 'id-ID')
                        .format(_transactions[index].amount),
                    style: const TextStyle(
                        // color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            });
  }
}
