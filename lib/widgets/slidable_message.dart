import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableMessage extends StatefulWidget {
  const SlidableMessage({
    Key? key,
    required this.icon,
    required this.sender,
    required this.content,
  }) : super(key: key);

  final Icon icon;
  final String sender;
  final String content;

  @override
  State<SlidableMessage> createState() => _SlidableMessageState();
}

class _SlidableMessageState extends State<SlidableMessage> {
  bool _isStarred = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              log('Starring');
              // Your star logic goes here.
              setState(() {
                _isStarred = !_isStarred;
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
        leading: widget.icon,
        title: Text(widget.sender),
        subtitle: Text(widget.content),
        trailing: Icon(_isStarred ? Icons.star : Icons.star_outline),
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
