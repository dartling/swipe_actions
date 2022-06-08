import 'package:flutter/material.dart';
import 'package:swipe_actions/widgets/dismissible_message.dart';
import 'package:swipe_actions/widgets/slidable_message.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe actions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Swipe actions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: const [
          DismissibleMessage(
            icon: Icon(Icons.flutter_dash),
            sender: 'Dash',
            content: 'Hello!',
          ),
          SlidableMessage(
            icon: Icon(Icons.swipe_left),
            sender: 'flutter_slidable',
            content: 'User me for even more actions.',
          ),
        ],
      ),
    );
  }
}
