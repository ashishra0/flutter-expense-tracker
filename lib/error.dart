import 'package:alfredexpensetracker/main.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DisplayErrorPage(),
    );
  }
}

class DisplayErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Oops! Looks like we',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 35.0,
                  ),
                ),
                Text(
                  'Messed Up!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Image(
                    image: AssetImage('images/bermuda-page-not-found.png'),
                    height: 230.0),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'Try again later',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                MaterialButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ));
                  },
                  child: Text(
                    'BACK HOME',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
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
