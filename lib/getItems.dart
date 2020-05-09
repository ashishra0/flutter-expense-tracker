import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'error.dart';


class GetItems extends StatefulWidget {
  @override
  _GetItemsState createState() => _GetItemsState();
}

class _GetItemsState extends State<GetItems> {
  ProgressDialog progressDialog;
  Map data;
  List itemData;
  var icon = Icons.refresh;

  Future getItems() async {
    try {
      var response = await http.get('https://alfred-expense-beta.herokuapp.com/v1/graphql');
      data = json.decode(response.body);
      setState(() {
        itemData = data['data']['Expense'];
      });
      progressDialog.update(
        message: 'List updated!',
        messageTextStyle: TextStyle(
          fontSize: 20.0,
        ),
      );
    } catch (err) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorPage(),
        ),
      );
    }
    await progressDialog.show();
    await progressDialog.hide();
  }

  convertToAmount(int cost) {
    return new FlutterMoneyFormatter(
            amount: double.parse(cost.toString()),
            settings: MoneyFormatterSettings(symbol: 'INR'))
        .output
        .symbolOnLeft;
  }

  parseDate(String date) {
    DateTime myDate = DateTime.parse(date);
    return DateFormat.yMMMMd("en_US").format(myDate);
  }

  @override
  void initState() {
    super.initState();
    getItems();
  }

  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(
      context,
      isDismissible: true,
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          brightness: Brightness.light,
          backgroundColor: Colors.white70,
          automaticallyImplyLeading: true,
          title: Text(
            'History',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Muli',
            ),
          ),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(icon),
              color: Colors.black87,
              onPressed: () {
                getItems();
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context, false),
            color: Colors.pinkAccent,
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10.0),
            itemCount: itemData == null ? 0 : itemData.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Card(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "${itemData[index]['item_name']}",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "#${itemData[index]['item_id']}",
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "${convertToAmount(itemData[index]['item_cost'])} • ${parseDate(itemData[index]['date'])}",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Item {
  final int item_id;
  final String item_name;
  final int item_cost;
  final String date;

  Item({this.item_id, this.item_name, this.item_cost, this.date});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        item_id: json['item_id'],
        item_name: json['item_name'],
        item_cost: json['item_cost'],
        date: json['date']);
  }
}
