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
              spacing: 16,
              children: [
                SizedBox(height: 20, child: Text("height: 20"),),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(80),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    height: 100,
                    //    padding: EdgeInsets.all(10),
                    //    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Container')
                    ),
                  ),
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
