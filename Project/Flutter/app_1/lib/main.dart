import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true, 
            title: const Text('My App'),
          ), 
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20, child: Text("height: 20"),),
                Container(
                  height: 100,
              //    padding: EdgeInsets.all(10),
              //    margin: EdgeInsets.all(10),
                  child: Text('Container'),
                ),
                Text('This is not my first Flutter app.'),
                Text('But I am still learning Flutter.'),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
