import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';


class GetItems extends StatefulWidget {
  @override
  _GetItemsState createState() => _GetItemsState();
}

class _GetItemsState extends State<GetItems> {
  ProgressDialog progressDialog;
  Map data;
  List itemData;
  var icon = Icons.refresh;

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
    // Todo: add localstorage method
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
          title: Center(
            child: Text(
              'History',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Muli',
              ),
            ),
          ),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(icon),
              color: Colors.black87,
              onPressed: () {
                // Todo: Add localstorage method
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
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                        SizedBox(height: 5.0),
                        Text(
                          "#${itemData[index]['item_id']}",
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                        SizedBox(height: 5.0),
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
