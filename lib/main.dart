import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        children: [
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            onDismissed: (DismissDirection direction) {
              log('Dismissed with direction $direction');
              // Your deletion logic goes here.
            },
            confirmDismiss: (DismissDirection direction) async {
              final confirmed = await _confirmDeletion(context);
              log('Deletion confirmed: $confirmed');
              return confirmed;
            },
            background: const ColoredBox(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: const ListTile(
              leading: Icon(Icons.flutter_dash),
              title: Text('Dash'),
              subtitle: Text('Hello!'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmDeletion(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }
}
