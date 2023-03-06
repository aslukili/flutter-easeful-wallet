import 'dart:convert';

import 'package:easeful_wallet/screens/transaction_screen.dart';
import 'package:easeful_wallet/screens/transactions_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _walletId = '';
  double _balance = 0;

  @override
  void initState() {
    super.initState();
    _fetchWalletData();
  }

  Future<void> _fetchWalletData() async {
    final response = await http.get(Uri.parse(
        'http://165.232.123.254:8080/api/v1/wallets/6405b09cc213d514b814888a'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _walletId = data['id'];
        _balance = data['balance'];
      });
    } else {
      throw Exception('Failed to load wallet data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wallet ID: $_walletId'),
            SizedBox(height: 16),
            Text('Balance: $_balance'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionScreen(),
                  ),
                );
              },
              child: Text('Make a Transaction'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionsListScreen(),
                  ),
                );
              },
              child: Text('View All Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}
