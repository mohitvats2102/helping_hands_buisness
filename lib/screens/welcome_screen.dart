import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Helping Hands',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          'Welcome To Your New Project.\nALL THE BEST',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
