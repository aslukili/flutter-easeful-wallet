import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select Transaction Type:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
// TODO: Implement deposit functionality
              },
              child: Text('Deposit'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
// TODO: Implement withdraw functionality
              },
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}
