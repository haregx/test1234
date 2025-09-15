import 'package:flutter/material.dart';

void main() {
  runApp( const MyApp424());
}

class MyApp424 extends StatelessWidget {
  const MyApp424(
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true, 
            title: const Text('Aufgabe 1'), 
            foregroundColor: Colors.black87,
            backgroundColor: Colors.blue,          
          ), 
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                SizedBox(height: 20),
                BlueText( 'Hello App Akademie'),
                BlueText( 'Hello App Akademie'),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(
                      buttonConfigs.length,
                      (index) => MyContainer(
                        background: buttonConfigs[index]['background'],
                        buttonBackground: buttonConfigs[index]['buttonBackground'],
                        buttonText: buttonConfigs[index]['buttonText'],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(
                      iconsConfigs.length,
                      (index) => MyIcon(
                        iconColor: iconsConfigs[index]['iconColor'],
                        iconData: iconsConfigs[index]['iconData'],
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class MyIcon extends StatelessWidget {
  final Color iconColor;
  final IconData iconData;
  final double iconSize;

  const MyIcon(
    {
      super.key,
      required this.iconColor,
      required this.iconData,
      this.iconSize = 96,
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  final Color background;
  final Color buttonBackground;
  final String buttonText;
  final Color buttonForeground;

  const MyContainer(
    {
      super.key,
      required this.background,
      required this.buttonBackground,
      required this.buttonText,
      this.buttonForeground = Colors.white,
      }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBackground,
            foregroundColor: buttonForeground,
          ),
          onPressed: () {},
          child: Text(buttonText),
        ),
      ),
    );
  }
}

class BlueText extends Text {
  const BlueText( 
    super.data, 
    { 
      super.key 
    }
  ) 
  : 
  super(
    style: const TextStyle(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.bold
    )
  );
}

List<Map<String, dynamic>> buttonConfigs = [
  {'background': Colors.red, 'buttonBackground': Colors.purple, 'buttonText': 'A'},
  {'background': Colors.green, 'buttonBackground': Colors.purple, 'buttonText': 'B'},
  {'background': Colors.blue, 'buttonBackground': Colors.purple, 'buttonText': 'C'},
  {'background': Colors.red, 'buttonBackground': Colors.purple, 'buttonText': 'A'},
  {'background': Colors.green, 'buttonBackground': Colors.purple, 'buttonText': 'B'},
  {'background': Colors.blue, 'buttonBackground': Colors.purple, 'buttonText': 'C'},
];

List<Map<String, dynamic>> iconsConfigs = [
  {'iconColor': Colors.black, 'iconData': Icons.face},
  {'iconColor': Colors.black, 'iconData': Icons.face},
  {'iconColor': Colors.black, 'iconData': Icons.face},
  {'iconColor': Colors.black, 'iconData': Icons.face},
];