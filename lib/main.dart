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
  bool _isStarred = false;

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
              if (direction == DismissDirection.endToStart) {
                // Your deletion logic goes here.
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                final confirmed = await _confirmDeletion(context);
                log('Deletion confirmed: $confirmed');
                return confirmed;
              } else {
                log('Starring');
                // The widget is never dismissed in this case. Your star logic goes here.
                setState(() {
                  _isStarred = !_isStarred;
                });
                return false;
              }
            },
            background: const ColoredBox(
              color: Colors.orange,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.star, color: Colors.white),
                ),
              ),
            ),
            secondaryBackground: const ColoredBox(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.flutter_dash),
              title: const Text('Dash'),
              subtitle: const Text('Hello!'),
              trailing: Icon(_isStarred ? Icons.star : Icons.star_outline),
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
