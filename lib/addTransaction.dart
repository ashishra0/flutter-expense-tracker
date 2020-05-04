import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  ProgressDialog progressDialog;
  var url = 'http://localhost:5000/v1/expense/create';
  var response;
  String itemName;
  int itemCost;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  Map<String, String> headers = {"Content-type": "application/json"};
  final _formKey = GlobalKey<FormState>();
  var error;

  _sendData(name, cost) async {
    try {
      response = await http.post(url,
          body: '{"item_name": "$name", "item_cost": $cost}', headers: headers);
      progressDialog.update(
        message: 'Good to go!',
        messageTextStyle: TextStyle(
          fontSize: 20.0,
        ),
      );
    } catch (err) {
      error = err;
      progressDialog.update(
        message: 'Something went wrong. Try again!',
        messageTextStyle: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
      );
    }
    await progressDialog.show();
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(
      context,
      isDismissible: true,
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.white70,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context, false),
            color: Colors.pinkAccent,
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Add your',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40.0,
                  ),
                ),
                Text(
                  'Expense',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
                Image(
                  image: AssetImage('images/payment-processed.png'),
                  height: 250.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter item',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter amount',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MaterialButton(
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.only(left: 50.0, right: 50.0),
                    onPressed: () {
                      _sendData(nameController.text, priceController.text);
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
