import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mybubble/model/bubble.model.dart';

class BubbleWidget extends StatelessWidget {

  final Bubble bubble;

  const BubbleWidget(this.bubble, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75 + min(bubble.data.length * 2.5, 175),
      height: 75 + min(bubble.data.length * 2.5, 175),
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha(5),
        boxShadow: const [
          BoxShadow(
              blurRadius: 10,
              color: Colors.grey,
              blurStyle: BlurStyle.outer)]
      ),
      child: ClipOval(
        child: Center(
          child: Text(
            bubble.data,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium)
        )
      ),
    );
  }
}