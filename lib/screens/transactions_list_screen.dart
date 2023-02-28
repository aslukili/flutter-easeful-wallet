import 'package:flutter/material.dart';

class TransactionsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Transaction $index'),
            subtitle: Text('January 1, 2022'),
            trailing: Text(
              '\$10.00',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
