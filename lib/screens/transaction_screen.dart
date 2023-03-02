import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController _valueController = TextEditingController();

  Future<void> _performTransaction(String transactionType) async {
    final double value = double.tryParse(_valueController.text) ?? 0;
    if (value <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction value must be greater than zero'),
        ),
      );
      return;
    }

    final Map<String, dynamic> requestData = <String, dynamic>{
      'amount': value,
      'walletId': '63fdda1bc213d514b8148884',
    };
    final response = await http.post(
      Uri.parse(
          'http://165.232.123.254:8080/api/v1/transactions/$transactionType'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction was successful'),
        ),
      );
      _valueController.clear();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to perform transaction: ${response.body}'),
        ),
      );
    }
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                decoration: InputDecoration(
                  labelText: "Value of your Transaction",
                  hintText: "Value of your transaction",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _performTransaction('deposit'),
              child: Text('Deposit'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _performTransaction('withdraw'),
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}
