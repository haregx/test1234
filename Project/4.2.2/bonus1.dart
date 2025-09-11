void main() {

  Widget app = MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Hello!'),
            Text('World!'),
          ],
        ),
      ),
    ),
  );  
}


class MaterialApp extends Widget{
  Widget home;
  MaterialApp({required this.home});
}

class Scaffold extends Widget{
  Widget body;
  Scaffold({required this.body});
}

class Column extends Widget{
  List<Widget> children;
  Column({required this.children});
}

class Text extends Widget {
  String content;
  Text(this.content);
}

class Center extends Widget {
  Widget child;
  Center({required this.child});
}


abstract class Widget {
  Widget();
}
