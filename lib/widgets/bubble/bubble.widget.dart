import 'package:flutter/material.dart';
import 'package:mybubble/model/bubble.model.dart';

class BubbleWidget extends StatelessWidget {

  final Bubble bubble;

  const BubbleWidget(this.bubble, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Center(
            child: Text(
                bubble.data,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium)
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueGrey.withAlpha(5),
            border: Border.all(
                color: Colors.blueGrey.withAlpha(30),
                width: 2)
        ),
      )
    );
  }
}