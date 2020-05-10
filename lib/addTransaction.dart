import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  ProgressDialog progressDialog;
  var url = 'https://bifrost-beta.herokuapp.com/v1/expense/create';
  var response;
  String itemName;
  int itemCost;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  Map<String, String> headers = {"Content-type": "application/json"};
  final _formKey = GlobalKey<FormState>();
  var error;

  displayAlert(value) {
    if (value == "200") {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Hooray!",
        desc: "Item saved successfully",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else if (value == "400") {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Oh no!",
        desc: "Unable to save item, please try again later!",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  _sendData(name, cost) async {
    try {
      response = await http.post(url,
          body: '{"item_name": "$name", "item_cost": $cost}', headers: headers);
      displayAlert("200");
    } catch (err) {
      error = err;
      displayAlert("400");
    }
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
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Add your',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 35.0,
                    ),
                  ),
                  Text(
                    'Expense',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  Image(
                    image: AssetImage('images/payment-processed.png'),
                    height: 200.0,
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
                        const EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
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
      ),
    );
  }
}
