import 'package:flutter/material.dart';

class MyFunnyPage extends StatefulWidget {
  const MyFunnyPage(
  {
      super.key, 
      required this.title
  });

  final String title;

  @override
  State<MyFunnyPage> createState() => _MyFunnyPageState();
}

class _MyFunnyPageState extends State<MyFunnyPage> {
  // ...existing code...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2, // 20%
                child: Center(
                  child: Text(
                    'Willkommen zur App!', 
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 6, // 60%
                child: Image.network(
                 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?auto=format&fit=crop&w=800&q=80',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2, // 20%
                child: Center(
                  child: Text(
                    'Bello hat gerade den Hamster vom Nachbarn vernascht.',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
