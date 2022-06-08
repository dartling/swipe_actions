import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  bool _isDashStarred = false;
  bool _isSlidableStarred = false;

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
                  _isDashStarred = !_isDashStarred;
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
              trailing: Icon(_isDashStarred ? Icons.star : Icons.star_outline),
            ),
          ),
          Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    // Your star logic goes here.
                    setState(() {
                      _isSlidableStarred = !_isSlidableStarred;
                    });
                  },
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  icon: Icons.star,
                  label: 'Star',
                ),
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(
                onDismissed: () {
                  // Your deletion logic goes here.
                },
                confirmDismiss: () async {
                  return await _confirmDeletion(context) ?? false;
                },
              ),
              children: [
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
                SlidableAction(
                  onPressed: (_) async {
                    if (await _confirmDeletion(context) ?? false) {
                      // Your deletion logic also goes here; we can delete either
                      // by tapping on this action or swiping the tile all the way left.
                    }
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.swipe),
              title: const Text('flutter_slidable'),
              subtitle: const Text('Use me for even more actions.'),
              trailing:
                  Icon(_isSlidableStarred ? Icons.star : Icons.star_outline),
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
