import 'package:flutter/material.dart';
import 'package:mybubble/model/bubble.model.dart';

class BubbleListItem extends StatelessWidget {

  final Bubble bubble;

  const BubbleListItem(this.bubble, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        title: Text(bubble.data, style: Theme.of(context).textTheme.subtitle1),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("<${bubble.id}>", style: Theme.of(context).textTheme.caption)
        ),
        leading: Icon(Icons.bubble_chart_outlined, color: Theme.of(context).colorScheme.secondary)
      )
    );
  }
}